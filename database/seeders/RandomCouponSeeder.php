<?php

namespace Database\Seeders;

use App\Models\Coupon;
use Illuminate\Database\Seeder;

class RandomCouponSeeder extends Seeder
{
    /**
     * Seed disposable coupon data for local/demo environments.
     */
    public function run(): void
    {
        Coupon::factory()->count(10)->create();

        $this->command->info('Random coupons created successfully!');
    }
}
