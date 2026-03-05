<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Services\AuditService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        set_time_limit(60);
        $validated = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $email = strtolower(trim($validated['email']));
        $password = trim($validated['password']);

        $admin = Admin::where('email', $email)->first();
        if (!$admin) {
            if (config('app.debug')) {
                \Log::warning('Admin login failed: email not found', ['email' => $email]);
            }
            sleep(1);
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        if (!Hash::check($password, $admin->password)) {
            if (config('app.debug')) {
                \Log::warning('Admin login failed: password mismatch', ['email' => $email]);
            }
            sleep(1);
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        // Check if admin account is active
        if (!$admin->is_active) {
            return response()->json(['message' => 'This administrator account is disabled'], 403);
        }

        $token = $admin->createToken('admin')->plainTextToken;
        
        AuditService::log('Login', 'Admin Logged In', $admin, null, $admin);

        return response()->json([
            'token' => $token,
            'admin' => [
                'id' => $admin->id,
                'name' => $admin->name,
                'email' => $admin->email,
                'roles' => $admin->roles()->pluck('slug')->values(),
                'permissions' => $admin->activeRoles()->with('permissions')->get()->pluck('permissions')->flatten()->pluck('slug')->unique()->values(),
            ],
        ]);
    }

    public function me(Request $request)
    {
        /** @var Admin $admin */
        $admin = $request->user();
        return response()->json([
            'id' => $admin->id,
            'name' => $admin->name,
            'email' => $admin->email,
            'roles' => $admin->roles()->pluck('slug')->values(),
            'permissions' => $admin->activeRoles()->with('permissions')->get()->pluck('permissions')->flatten()->pluck('slug')->unique()->values(),
        ]);
    }

    public function logout(Request $request)
    {
        /** @var Admin $admin */
        $admin = $request->user();
        $admin->currentAccessToken()->delete();
        return response()->json(['message' => 'Logged out']);
    }
}
