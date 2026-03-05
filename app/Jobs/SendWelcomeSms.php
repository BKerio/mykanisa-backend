<?php

namespace App\Jobs;

use App\Models\Member;
use App\Services\SmsService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class SendWelcomeSms implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected Member $member;

    /**
     * Create a new job instance.
     */
    public function __construct(Member $member)
    {
        $this->member = $member;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        if (empty($this->member->telephone)) {
            Log::warning('Member has no telephone number', [
                'member_id' => $this->member->id,
            ]);
            return;
        }

        try {
            $smsService = new SmsService();

            $greeting = $this->getGreeting();

            $welcomeMessage = "{$greeting}, {$this->member->full_name}! 🎉 "
                . "Welcome to {$this->member->congregation}. "
                . "Your Kanisa Number is {$this->member->e_kanisa_number}. "
                . "You can now log in to your account to manage your membership. "
                . "Stay connected with your congregation anytime, anywhere.";

            $smsService->sendSms($this->member->telephone, $welcomeMessage);

            Log::info('Welcome SMS sent successfully', [
                'member_id' => $this->member->id,
                'telephone' => $this->member->telephone,
            ]);

        } catch (\Exception $e) {
            Log::error('Failed to send welcome SMS in job', [
                'member_id' => $this->member->id,
                'error' => $e->getMessage(),
            ]);
        }
    }

    /**
     * Determine greeting based on time of day.
     */
    private function getGreeting(): string
    {
        $hour = Carbon::now(config('app.timezone'))->hour;

        if ($hour < 12) {
            return 'Good morning';
        }

        if ($hour < 17) {
            return 'Good afternoon';
        }

        return 'Good evening';
    }
}
