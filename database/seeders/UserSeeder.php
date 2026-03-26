<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        app(PermissionRegistrar::class)->forgetCachedPermissions();

        $superAdminRole = Role::findOrCreate('super_admin', 'web');

        // Create admin user
        $primaryAdmin = User::updateOrCreate(
            ['email' => 'newadmin@example.com'],
            [
                'name' => 'New Admin User',
                'password' => Hash::make('password'),
                'phone' => '+1234567890',
                'is_active' => true,
                'email_verified_at' => now(),
            ],
        );

        // Create additional admin users
        $secondaryAdmin = User::updateOrCreate(
            ['email' => 'john@example.com'],
            [
                'name' => 'John Doe',
                'password' => Hash::make('password'),
                'phone' => '+1234567891',
                'is_active' => true,
                'email_verified_at' => now(),
            ],
        );

        $primaryAdmin->syncRoles([$superAdminRole]);
        $secondaryAdmin->syncRoles([$superAdminRole]);

        $this->command->info('Admin users created successfully with super_admin access.');
    }
}
