<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('announcements', function (Blueprint $table) {
            $table->string('media_path')->nullable()->after('message');
            $table->string('media_type')->nullable()->after('media_path'); // 'image', 'document'
            $table->string('media_original_name')->nullable()->after('media_type');
            $table->integer('media_size')->nullable()->after('media_original_name'); // in bytes
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('announcements', function (Blueprint $table) {
            $table->dropColumn(['media_path', 'media_type', 'media_original_name', 'media_size']);
        });
    }
};
