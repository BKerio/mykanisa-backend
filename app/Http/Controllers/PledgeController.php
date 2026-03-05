<?php

namespace App\Http\Controllers;

use App\Models\Pledge;
use App\Models\Member;
use App\Models\AuditLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class PledgeController extends Controller
{
    /**
     * Get all pledges for the authenticated member
     */
    public function index(Request $request)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['status' => 401, 'message' => 'Unauthorized'], 401);
        }

        $member = Member::where('email', $user->email)->first();
        if (!$member) {
            return response()->json(['status' => 404, 'message' => 'Member not found'], 404);
        }

        try {
            $status = $request->input('status'); // active, fulfilled, cancelled, or null for all
            $accountType = $request->input('account_type');
            $period = $request->input('period'); // Weekly, Monthly, etc.

            $query = Pledge::where('member_id', $member->id)
                ->with('member')
                ->orderBy('pledge_date', 'desc');

            if ($status) {
                $query->where('status', $status);
            }

            if ($accountType) {
                $query->where('account_type', $accountType);
            }

            if ($period) {
                $query->where('period', $period);
            }

            $pledges = $query->get();

            // Calculate summary statistics
            $totalPledged = $pledges->sum('pledge_amount');
            $totalFulfilled = $pledges->sum('fulfilled_amount');
            $totalRemaining = $pledges->sum('remaining_amount');

            // Calculate period-based summaries
            $periodSummaries = [];
            $periods = ['Weekly', 'Monthly', 'Quarterly', 'Yearly'];
            
            foreach ($periods as $periodType) {
                $periodPledges = $pledges->where('period', $periodType);
                $periodSummaries[$periodType] = [
                    'total_pledged' => $periodPledges->sum('pledge_amount'),
                    'total_fulfilled' => $periodPledges->sum('fulfilled_amount'),
                    'total_remaining' => $periodPledges->sum('remaining_amount'),
                    'count' => $periodPledges->count(),
                ];
            }

            return response()->json([
                'status' => 200,
                'pledges' => $pledges,
                'summary' => [
                    'total_pledged' => $totalPledged,
                    'total_fulfilled' => $totalFulfilled,
                    'total_remaining' => $totalRemaining,
                    'fulfillment_percentage' => $totalPledged > 0 ? ($totalFulfilled / $totalPledged) * 100 : 0,
                ],
                'period_summaries' => $periodSummaries,
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching pledges', [
                'member_id' => $member->id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'status' => 500,
                'message' => 'Error fetching pledges'
            ], 500);
        }
    }

    /**
     * Create a new pledge
     */
    public function store(Request $request)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['status' => 401, 'message' => 'Unauthorized'], 401);
        }

        $member = Member::where('email', $user->email)->first();
        if (!$member) {
            return response()->json(['status' => 404, 'message' => 'Member not found'], 404);
        }

        $validated = $request->validate([
            'account_type' => 'required|string|in:Tithe,Offering,Development,Thanksgiving,FirstFruit,Others',
            'pledge_amount' => 'required|numeric|min:0.01',
            'target_date' => 'nullable|date|after:today',
            'description' => 'nullable|string|max:500',
            'period' => 'nullable|string|in:Weekly,Monthly,Quarterly,Yearly',
        ]);

        try {
            DB::beginTransaction();

            // Check if there's already an active pledge for the same account type and period
            $existingPledge = Pledge::where('member_id', $member->id)
                ->where('account_type', $validated['account_type'])
                ->where('period', $validated['period'] ?? null)
                ->where('status', 'active')
                ->first();

            if ($existingPledge) {
                // Consolidate: Increment existing pledge amount
                $oldAmount = $existingPledge->pledge_amount;
                $newAddedAmount = $validated['pledge_amount'];
                
                $existingPledge->pledge_amount += $newAddedAmount;
                $existingPledge->remaining_amount += $newAddedAmount;
                
                // Update target date and description if provided
                if (isset($validated['target_date'])) {
                    $existingPledge->target_date = $validated['target_date'];
                }
                if (isset($validated['description'])) {
                    $existingPledge->description = $validated['description'];
                }
                
                $existingPledge->save();
                $pledge = $existingPledge;
                
                $action = 'consolidate';
                $logDescription = "Consolidated {$validated['account_type']} pledge. Added KES {$newAddedAmount} to existing KES {$oldAmount}. New total: KES {$existingPledge->pledge_amount}";
            } else {
                // Create new pledge
                $pledge = Pledge::create([
                    'member_id' => $member->id,
                    'account_type' => $validated['account_type'],
                    'pledge_amount' => $validated['pledge_amount'],
                    'remaining_amount' => $validated['pledge_amount'],
                    'fulfilled_amount' => 0,
                    'pledge_date' => now(),
                    'target_date' => $validated['target_date'] ?? null,
                    'description' => $validated['description'] ?? null,
                    'period' => $validated['period'] ?? null,
                    'status' => 'active',
                ]);
                
                $action = 'create';
                $logDescription = "Created {$validated['account_type']} pledge for KES {$validated['pledge_amount']}";
            }

            // Create audit log
            AuditLog::create([
                'user_id' => $user->id,
                'user_type' => get_class($user),
                'action' => $action,
                'model_type' => 'Pledge',
                'model_id' => $pledge->id,
                'description' => $logDescription,
                'details' => [
                    'account_type' => $validated['account_type'],
                    'pledge_amount' => $validated['pledge_amount'],
                    'period' => $validated['period'] ?? null,
                    'target_date' => $validated['target_date'] ?? null,
                    'is_consolidation' => $existingPledge ? true : false,
                ],
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
            ]);

            DB::commit();

            return response()->json([
                'status' => $existingPledge ? 200 : 201, // Keep status field as 200 for internal logic if needed
                'message' => $existingPledge ? 'Pledge consolidated successfully' : 'Pledge created successfully',
                'pledge' => $pledge->load('member')
            ], 201); // ALWAYS return 201 to make frontend happy
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating pledge', [
                'member_id' => $member->id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'status' => 500,
                'message' => 'Error creating pledge'
            ], 500);
        }
    }

    /**
     * Get a specific pledge
     */
    public function show(Request $request, $id)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['status' => 401, 'message' => 'Unauthorized'], 401);
        }

        $member = Member::where('email', $user->email)->first();
        if (!$member) {
            return response()->json(['status' => 404, 'message' => 'Member not found'], 404);
        }

        try {
            $pledge = Pledge::where('id', $id)
                ->where('member_id', $member->id)
                ->with('member')
                ->first();

            if (!$pledge) {
                return response()->json([
                    'status' => 404,
                    'message' => 'Pledge not found'
                ], 404);
            }

            return response()->json([
                'status' => 200,
                'pledge' => $pledge
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching pledge', [
                'pledge_id' => $id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'status' => 500,
                'message' => 'Error fetching pledge'
            ], 500);
        }
    }

    /**
     * Update a pledge
     */
    public function update(Request $request, $id)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['status' => 401, 'message' => 'Unauthorized'], 401);
        }

        $member = Member::where('email', $user->email)->first();
        if (!$member) {
            return response()->json(['status' => 404, 'message' => 'Member not found'], 404);
        }

        $pledge = Pledge::where('id', $id)
            ->where('member_id', $member->id)
            ->first();

        if (!$pledge) {
            return response()->json([
                'status' => 404,
                'message' => 'Pledge not found'
            ], 404);
        }

        // Only allow updating active pledges
        if ($pledge->status !== 'active') {
            return response()->json([
                'status' => 400,
                'message' => 'Can only update active pledges'
            ], 400);
        }

        // Get all request data to check which fields are being updated
        $requestData = $request->all();
        
        // Validate fields individually to handle null values properly
        $rules = [];
        if (array_key_exists('pledge_amount', $requestData)) {
            $rules['pledge_amount'] = 'required|numeric|min:0.01';
        }
        if (array_key_exists('target_date', $requestData)) {
            $rules['target_date'] = 'nullable|date';
        }
        if (array_key_exists('description', $requestData)) {
            $rules['description'] = 'nullable|string|max:500';
        }

        $validated = $request->validate($rules);

        try {
            // If updating pledge amount, adjust remaining amount proportionally
            if (isset($validated['pledge_amount']) && $validated['pledge_amount'] != $pledge->pledge_amount) {
                $oldPledgeAmount = $pledge->pledge_amount;
                $newPledgeAmount = $validated['pledge_amount'];
                
                // Calculate new remaining amount based on fulfillment percentage
                $fulfillmentPercentage = $pledge->getFulfillmentPercentage() / 100;
                $newFulfilledAmount = $newPledgeAmount * $fulfillmentPercentage;
                $newRemainingAmount = $newPledgeAmount - $newFulfilledAmount;
                
                $pledge->pledge_amount = $newPledgeAmount;
                $pledge->fulfilled_amount = $newFulfilledAmount;
                $pledge->remaining_amount = max(0, $newRemainingAmount);
            }

            // Handle target_date - allow clearing by sending null
            if (array_key_exists('target_date', $requestData)) {
                $targetDateValue = $requestData['target_date'];
                if ($targetDateValue === null || $targetDateValue === '') {
                    $pledge->target_date = null;
                } else {
                    // Use validated value if available, otherwise use request value
                    $pledge->target_date = $validated['target_date'] ?? $targetDateValue;
                }
            }

            // Handle description - allow clearing by sending null or empty string
            if (array_key_exists('description', $requestData)) {
                $descriptionValue = $requestData['description'];
                if ($descriptionValue === null || $descriptionValue === '') {
                    $pledge->description = null;
                } else {
                    // Use validated value if available, otherwise use request value
                    $pledge->description = $validated['description'] ?? $descriptionValue;
                }
            }

            $pledge->save();

            // Create audit log
            AuditLog::create([
                'user_id' => $request->user()->id,
                'user_type' => get_class($request->user()),
                'action' => 'update',
                'model_type' => 'Pledge',
                'model_id' => $pledge->id,
                'description' => "Updated {$pledge->account_type} pledge",
                'details' => $validated,
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
            ]);

            return response()->json([
                'status' => 200,
                'message' => 'Pledge updated successfully',
                'pledge' => $pledge->load('member')
            ]);
        } catch (\Exception $e) {
            Log::error('Error updating pledge', [
                'pledge_id' => $id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'status' => 500,
                'message' => 'Error updating pledge'
            ], 500);
        }
    }

    /**
     * Cancel a pledge
     */
    public function destroy(Request $request, $id)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['status' => 401, 'message' => 'Unauthorized'], 401);
        }

        $member = Member::where('email', $user->email)->first();
        if (!$member) {
            return response()->json(['status' => 404, 'message' => 'Member not found'], 404);
        }

        $pledge = Pledge::where('id', $id)
            ->where('member_id', $member->id)
            ->first();

        if (!$pledge) {
            return response()->json([
                'status' => 404,
                'message' => 'Pledge not found'
            ], 404);
        }

        try {
            // Mark as cancelled instead of deleting
            $pledge->status = 'cancelled';
            $pledge->save();

            // Create audit log
            AuditLog::create([
                'user_id' => $request->user()->id,
                'user_type' => get_class($request->user()),
                'action' => 'cancel',
                'model_type' => 'Pledge',
                'model_id' => $pledge->id,
                'description' => "Cancelled {$pledge->account_type} pledge for KES {$pledge->pledge_amount}",
                'details' => [
                    'account_type' => $pledge->account_type,
                    'pledge_amount' => $pledge->pledge_amount,
                    'fulfilled_amount' => $pledge->fulfilled_amount,
                    'remaining_amount' => $pledge->remaining_amount,
                ],
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
            ]);

            return response()->json([
                'status' => 200,
                'message' => 'Pledge cancelled successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Error cancelling pledge', [
                'pledge_id' => $id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'status' => 500,
                'message' => 'Error cancelling pledge'
            ], 500);
        }
    }
}

