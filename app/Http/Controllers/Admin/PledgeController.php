<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Pledge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PledgeController extends Controller
{
    /**
     * Display a listing of pledges with filtering and summary.
     */
    public function index(Request $request)
    {
        $perPage = (int)($request->query('per_page', 20));
        $status = $request->query('status');
        $period = $request->query('period');
        $accountType = $request->query('account_type');
        $search = trim((string)$request->query('q', ''));
        $dateFrom = $request->query('date_from');
        $dateTo = $request->query('date_to');

        // Base Query
        $query = Pledge::with(['member:id,full_name,e_kanisa_number,congregation,telephone']);

        // 1. Filtering by Status
        if ($status && $status !== 'all') {
            $query->where('status', $status);
        }

        // 2. Filtering by Period
        if ($period && $period !== 'all') {
            $query->where('period', $period);
        }

        // 3. Filtering by Account Type
        if ($accountType && $accountType !== 'all') {
            $query->where('account_type', $accountType);
        }

        // 4. Date Range Filtering
        if ($dateFrom) {
            $query->whereDate('pledge_date', '>=', $dateFrom);
        }
        if ($dateTo) {
            $query->whereDate('pledge_date', '<=', $dateTo);
        }

        // 5. Search (Member Name, Number, or Pledge Description)
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->whereHas('member', function ($mq) use ($search) {
                    $mq->where('full_name', 'like', "%{$search}%")
                       ->orWhere('e_kanisa_number', 'like', "%{$search}%");
                })
                ->orWhere('description', 'like', "%{$search}%")
                ->orWhere('account_type', 'like', "%{$search}%");
            });
        }

        // Clone query for statistics before pagination
        $statsQuery = clone $query;

        // Execute Query
        $pledges = $query->orderByDesc('pledge_date')
                         ->paginate($perPage);

        // Calculate Summary Statistics based on the filtered data
        $summary = [
            'total_pledged' => $statsQuery->sum('pledge_amount'),
            'total_fulfilled' => $statsQuery->sum('fulfilled_amount'),
            'total_remaining' => $statsQuery->sum('remaining_amount'),
            'count' => $statsQuery->count(),
        ];

        // Add periodic breakdown for charts/overview if needed
        $periodBreakdown = $statsQuery->select('period', DB::raw('sum(pledge_amount) as total'), DB::raw('count(*) as count'))
            ->groupBy('period')
            ->pluck('total', 'period'); // Returns [ 'Monthly' => 1000, 'Weekly' => 500 ]

        return response()->json([
            'data' => $pledges->items(),
            'current_page' => $pledges->currentPage(),
            'last_page' => $pledges->lastPage(),
            'per_page' => $pledges->perPage(),
            'total' => $pledges->total(),
            'summary' => $summary,
            'period_breakdown' => $periodBreakdown
        ]);
    }

    /**
     * Show specific pledge details.
     */
    public function show($id)
    {
        $pledge = Pledge::with('member')->find($id);

        if (!$pledge) {
            return response()->json(['message' => 'Pledge not found'], 404);
        }

        return response()->json($pledge);
    }
}
