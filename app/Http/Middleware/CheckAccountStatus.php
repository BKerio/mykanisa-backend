<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CheckAccountStatus
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();

        if ($user && isset($user->is_active) && !$user->is_active) {
            // Log out the user/admin if they are using a session or delete the current token
            if ($request->bearerToken()) {
               $user->currentAccessToken()->delete();
            }

            return response()->json([
                'status' => 403,
                'message' => 'Your account has been disabled. Please contact the administrator.'
            ], 403);
        }

        return $next($request);
    }
}
