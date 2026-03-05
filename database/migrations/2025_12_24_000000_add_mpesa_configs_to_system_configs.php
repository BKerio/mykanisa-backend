<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Crypt;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Insert M-Pesa configuration
        DB::table('system_configs')->insert([
            [
                'key' => 'mpesa_consumer_key',
                'value' => Crypt::encryptString('SxRBEgsFO1VGGYbb7kMjMR8bNcNxqzgtR9IA9ATtN7R7HAiq'),
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Consumer Key',
                'is_encrypted' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_consumer_secret',
                'value' => Crypt::encryptString('XztAhsZCTihnmlEmVf1YKyHgThSAtDADrqHMESgjwe4Zhvqn0hCzHDCWjlXWamkW'),
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Consumer Secret',
                'is_encrypted' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_passkey',
                'value' => Crypt::encryptString('bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'),
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Passkey (for STK Push)',
                'is_encrypted' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_shortcode',
                'value' => '174379',
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Business Shortcode (Paybill/Store)',
                'is_encrypted' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_till_no',
                'value' => '174379',
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Till Number (if applicable)',
                'is_encrypted' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_env',
                'value' => 'sandbox',
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Environment (sandbox or live)',
                'is_encrypted' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key' => 'mpesa_callback_url',
                'value' => 'https://91605a1b393d.ngrok-free.app/api/mpesa/callback',
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Callback URL',
                'is_encrypted' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::table('system_configs')
            ->where('category', 'mpesa')
            ->delete();
    }
};
