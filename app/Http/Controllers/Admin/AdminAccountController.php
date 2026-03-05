<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Services\AuditService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class AdminAccountController extends Controller
{
    /**
     * Get current admin account details
     */
    public function show(Request $request)
    {
        /** @var Admin $admin */
        $admin = $request->user();
        
        $roles = [];
        try {
            // Check if the method exists AND doesn't throw a DB error
            if (method_exists($admin, 'activeRoles')) {
                // Wrap specifically the DB call
                $activeRoles = $admin->activeRoles()->with('permissions')->get();
                $roles = $activeRoles->map(function($role) {
                    return [
                        'id' => $role->id,
                        'name' => $role->name,
                        'slug' => $role->slug,
                        'permissions' => $role->permissions->pluck('name')
                    ];
                })->toArray();
            }
        } catch (\Throwable $e) {
            // If any error occurs (like missing table), log it and return empty roles
            \Log::error('Error loading admin roles: ' . $e->getMessage());
        }
        
        return response()->json([
            'id' => $admin->id,
            'name' => $admin->name,
            'email' => $admin->email,
            'created_at' => $admin->created_at ? $admin->created_at->toISOString() : null,
            'updated_at' => $admin->updated_at ? $admin->updated_at->toISOString() : null,
            'roles' => $roles
        ]);
    }

    /**
     * Update admin profile (name, email)
     */
    public function update(Request $request)
    {
        /** @var Admin $admin */
        $admin = $request->user();
        
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:admins,email,' . $admin->id,
        ]);

        $oldData = [
            'name' => $admin->name,
            'email' => $admin->email
        ];

        $admin->update([
            'name' => $validated['name'],
            'email' => strtolower(trim($validated['email'])),
        ]);

        // Log the update
        AuditService::log(
            'Profile Update',
            'Admin updated their profile',
            $admin,
            $oldData,
            $admin
        );

        return response()->json([
            'message' => 'Profile updated successfully',
            'admin' => [
                'id' => $admin->id,
                'name' => $admin->name,
                'email' => $admin->email,
            ]
        ]);
    }

    /**
     * Update admin password
     */
    public function updatePassword(Request $request)
    {
        /** @var Admin $admin */
        $admin = $request->user();
        
        $validated = $request->validate([
            'current_password' => 'required|string',
            'new_password' => ['required', 'string', 'confirmed', Password::min(8)],
        ]);

        // Verify current password
        if (!Hash::check($validated['current_password'], $admin->password)) {
            return response()->json([
                'message' => 'Current password is incorrect',
                'errors' => [
                    'current_password' => ['The current password is incorrect']
                ]
            ], 422);
        }

        // Update password
        $admin->update([
            'password' => Hash::make($validated['new_password']),
        ]);

        // Log the password change
        AuditService::log(
            'Password Change',
            'Admin changed their password',
            $admin,
            null,
            $admin
        );

        return response()->json([
            'message' => 'Password updated successfully'
        ]);
    }
}
