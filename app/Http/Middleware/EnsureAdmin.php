<?php

namespace App\Http\Middleware;

use App\Models\Admin;
use Closure;
use Illuminate\Http\Request;

class EnsureAdmin
{
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();
        
        // Allow Admin and Elder (Elder has full permissions)
        if ($user instanceof Admin) {
            return $next($request);
        }
        
        \Log::info('EnsureAdmin check failed', [
            'user_id' => $user->id ?? null,
            'user_class' => $user ? get_class($user) : 'null',
            'email' => $user->email ?? null
        ]);
        
        // Check if Member has Elder role
        if ($user instanceof \App\Models\Member && $user->hasRole('elder')) {
            return $next($request);
        }
        
        return response()->json(['message' => 'Unauthorized'], 401);
    }
}



