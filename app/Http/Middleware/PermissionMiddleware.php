<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Member;
use App\Models\Admin;

class PermissionMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @param  string  $permission
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next, string $permission)
    {
        if (!Auth::check()) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        $user = Auth::user();
        $hasPermission = false;

        // Check if user is a Member
        if ($user instanceof Member) {
            // Elder has full permissions - bypass check
            if ($user->hasRole('elder')) {
                $hasPermission = true;
            } else {
                $hasPermission = $user->hasPermission($permission);
            }
        }
        // Check if user is an Admin
        elseif ($user instanceof Admin) {
            // Broad bypass for role management or systemic bypass for admins
            if (in_array($permission, ['manage_roles', 'manage_permissions']) || $user->id === 1) {
                $hasPermission = true;
            } else {
                $hasPermission = $user->hasPermission($permission);
            }
        }
        // If user is a regular User, try to find associated Member
        else {
            \Log::info('PermissionMiddleware: User is generic User model', ['email' => $user->email]);
            $member = Member::where('email', $user->email)->first();
            if ($member) {
                // Elder has full permissions - bypass check
                if ($member->hasRole('elder')) {
                    $hasPermission = true;
                } else {
                    $hasPermission = $member->hasPermission($permission);
                }
            }
        }

        if (!$hasPermission) {
            \Log::info('PermissionMiddleware check failed', [
                'user_id' => $user->id,
                'user_class' => get_class($user),
                'permission' => $permission,
                'email' => $user->email
            ]);
        }

        if (!$hasPermission) {
            return response()->json([
                'message' => 'Insufficient permissions. Required permission: ' . $permission
            ], 403);
        }

        return $next($request);
    }
}

