<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('system_configs')->insert([
            [
                'key' => 'mpesa_transaction_type',
                'value' => 'CustomerBuyGoodsOnline',
                'type' => 'string',
                'category' => 'mpesa',
                'description' => 'M-Pesa Transaction Type (CustomerPayBillOnline or CustomerBuyGoodsOnline)',
                'is_encrypted' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ]
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
            ->where('key', 'mpesa_transaction_type')
            ->delete();
    }
};
