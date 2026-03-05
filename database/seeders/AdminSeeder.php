<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        $email = 'admin@pcea.com';
        $exists = DB::table('admins')->where('email', $email)->exists();
        if ($exists) {
            DB::table('admins')->where('email', $email)->update([
                'name' => 'System Admin',
                'password' => Hash::make('123456'),
                'updated_at' => now(),
            ]);
        } else {
            $adminId = DB::table('admins')->insertGetId([
                'name' => 'System Admin',
                'email' => $email,
                'password' => Hash::make('123456'),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Assign system_admin role
            $role = DB::table('roles')->where('slug', 'system_admin')->first();
            if ($role) {
                DB::table('admin_roles')->insert([
                    'admin_id' => $adminId,
                    'role_id' => $role->id,
                    'is_active' => true,
                    'assigned_at' => now(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}









