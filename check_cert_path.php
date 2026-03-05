<?php
use App\Models\Member;

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$member = Member::whereNotNull('marriage_certificate_path')->latest('updated_at')->first();

if ($member) {
    echo "ID: " . $member->id . "\n";
    echo "Name: " . $member->full_name . "\n";
    echo "Path: " . $member->marriage_certificate_path . "\n";
    echo "URL would be: " . asset('storage/' . $member->marriage_certificate_path) . "\n";
    if ($member->profile_image) {
        echo "Profile Image Path: " . $member->profile_image . "\n";
        echo "Profile Image URL: " . asset('storage/' . $member->profile_image) . "\n";
    }
} else {
    echo "No member with certificate found.\n";
}
