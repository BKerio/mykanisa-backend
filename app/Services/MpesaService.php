<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use App\Models\SystemConfig;


class MpesaService
{
    private $baseUrl;
    private $consumerKey;
    private $consumerSecret;
    private $shortcode; //Paybill (for password generation)
    private $tillno; //BuyGoods Till Number
    private $passkey;
    private $callbackUrl;

    public function __construct()
    {
        $env = SystemConfig::getValue('mpesa_env', 'live');
        $this->baseUrl = $env === 'live'
            ? 'https://api.safaricom.co.ke'
            : 'https://sandbox.safaricom.co.ke';

        $this->consumerKey    = SystemConfig::getValue('mpesa_consumer_key');
        $this->consumerSecret = SystemConfig::getValue('mpesa_consumer_secret');
        $this->shortcode      = SystemConfig::getValue('mpesa_shortcode');
        $this->tillno         = SystemConfig::getValue('mpesa_till_no');    
        $this->passkey        = SystemConfig::getValue('mpesa_passkey');
        $this->callbackUrl    = SystemConfig::getValue('mpesa_callback_url');
    }

    private function getAccessToken()
    {
        $response = Http::withBasicAuth($this->consumerKey, $this->consumerSecret)
            ->get($this->baseUrl . '/oauth/v1/generate?grant_type=client_credentials');

        return $response->json()['access_token'] ?? null;
    }

    public function stkPush($phone, $amount, $reference = 'Payment')
    {
        //converting m-pesa phone number to 2547XXXXXXXX format
        $phone = preg_replace('/^0/', '254', $phone);
        $phone = ltrim($phone, '+');

        $timestamp = now()->format('YmdHis');
        $password  = base64_encode($this->shortcode . $this->passkey . $timestamp);

        $token = $this->getAccessToken();

        $transactionType = SystemConfig::getValue('mpesa_transaction_type', 'CustomerBuyGoodsOnline');

        $payload = [
            "BusinessShortCode" => $this->shortcode,      // Paybill used in password
            "Password"          => $password,
            "Timestamp"         => $timestamp,
            "TransactionType"   => $transactionType,
            "Amount"            => $amount,
            "PartyA"            => $phone,//m-pesa number
            "PartyB"            => $this->tillno,//Till Number
            "PhoneNumber"       => $phone,//same as PartyA
            "CallBackURL"       => $this->callbackUrl,
            "AccountReference"  => $reference, 
            "TransactionDesc"   => $reference,
        ];

        $response = Http::withToken($token)
            ->post($this->baseUrl . '/mpesa/stkpush/v1/processrequest', $payload);

        return $response->json();
    }
}