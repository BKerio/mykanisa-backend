<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
use App\Models\Role;
use App\Models\Permission;
use Illuminate\Support\Facades\Hash;

class AsherSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Create specialized Role for Attendance Staff
        $roleSlug = 'attendance_staff';
        $role = Role::firstOrCreate(
            ['slug' => $roleSlug],
            [
                'name' => 'Attendance Staff',
                'description' => 'Staff member responsible for administering digital attendance',
                'is_system_role' => false, // Custom role
                'hierarchy_level' => 50,
            ]
        );

        // 2. Assign existing permissions to this role
        // Based on RolePermissionSeeder, we choose relevant view permissions
        $permissions = [
            'view_members',
            'view_congregations',
            'view_reports',
            // Add any other relevant permissions found in RolePermissionSeeder
            // 'manage_attendance' doesn't exist as a permission slug yet, 
            // but Admin middleware allows access to attendance controller.
            // Giving them access to view members is key for attendance.
        ];

        $permissionIds = Permission::whereIn('slug', $permissions)->pluck('id');
        $role->permissions()->sync($permissionIds);
        
        $this->command->info("Role '$roleSlug' configured with " . count($permissionIds) . " permissions.");

        // 3. Create or Update Asher Admin User
        $email = 'asher@pcea.com';
        $admin = Admin::where('email', $email)->first();

        if ($admin) {
            $admin->update([
                'name' => 'Asher',
                'password' => Hash::make('123456'),
            ]);
            $this->command->info("Admin user 'Asher' updated.");
        } else {
            $admin = Admin::create([
                'name' => 'Asher',
                'email' => $email,
                'password' => Hash::make('123456'),
            ]);
            $this->command->info("Admin user 'Asher' created.");
        }

        // 4. Assign the role to the user
        // Using assignRole method from Admin model trait/method
        // public function assignRole($role, $expiresAt = null)
        if (!$admin->hasRole($roleSlug)) {
            $admin->assignRole($role);
            $this->command->info("Assigned '$roleSlug' role to Asher.");
        } else {
             $this->command->info("Asher already has '$roleSlug' role.");
        }
    }
}
