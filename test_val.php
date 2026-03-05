<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

$req = Illuminate\Http\Request::create('api/admin/system-config/bulk-update', 'POST', [
    'configs' => [
        ['key' => 'test', 'value' => null],
        ['key' => 'test2', 'value' => '']
    ]
]);

$v = Illuminate\Support\Facades\Validator::make($req->all(), [
    'configs' => 'required|array',
    'configs.*.key' => 'required|string',
    'configs.*.value' => 'nullable',
]);

dump($v->fails() ? $v->errors()->toArray() : 'passed');
