<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class EnvironmentBootstrapSeeder extends Seeder
{
    /**
     * Seed deterministic baseline data for a brand-new environment.
     *
     * This seeder is intended for one-time bootstrap jobs in deployed
     * environments, so it avoids random factory/demo data.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            CategorySeeder::class,
            BrandSeeder::class,
            CouponSeeder::class,
            SettingSeeder::class,
        ]);
    }
}
