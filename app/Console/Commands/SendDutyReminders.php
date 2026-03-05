<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\MinuteActionItem;
use App\Services\SmsService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class SendDutyReminders extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'duty:remind {--dry-run : Do not send SMS, just log recipients}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send SMS reminders for duties/action items due soon or overdue';

    /**
     * Execute the console command.
     */
    public function handle(SmsService $smsService): int
    {
        $this->info("Looking for duties requiring reminders...");

        $today = Carbon::today();
        $tomorrow = Carbon::tomorrow();

        // Query pending or in-progress tasks
        $tasks = MinuteActionItem::with(['responsibleMember', 'minute'])
            ->whereIn('status', ['Pending', 'In progress'])
            ->whereNotNull('due_date')
            ->whereNotNull('responsible_member_id')
            ->get();

        if ($tasks->isEmpty()) {
            $this->info('No pending duties found.');
            return self::SUCCESS;
        }

        $sentCount = 0;
        $dryRun = (bool) $this->option('dry-run');

        foreach ($tasks as $task) {
            $member = $task->responsibleMember;
            if (!$member || empty($member->telephone)) {
                continue;
            }

            $dueDate = $task->due_date;
            $reminderType = null;
            $cacheKey = "duty_reminder_sent:{$task->id}:";

            if ($dueDate->isToday()) {
                $reminderType = 'TODAY';
                $cacheKey .= "today";
            } elseif ($dueDate->isTomorrow()) {
                $reminderType = 'TOMORROW';
                $cacheKey .= "tomorrow";
            } elseif ($dueDate->isPast()) {
                $reminderType = 'OVERDUE';
                // For overdue, we send every 3 days to avoid spamming too much
                $daysOverdue = (int) $dueDate->diffInDays($today);
                if ($daysOverdue % 3 !== 0) {
                    continue;
                }
                $cacheKey .= "overdue_{$today->format('Ymd')}";
            } else {
                // Future but not tomorrow
                continue;
            }

            // Avoid duplicate on the same day/type
            if (Cache::has($cacheKey)) {
                continue;
            }

            $message = $this->buildMessage($task, $reminderType);

            if ($dryRun) {
                $this->info("[Dry Run] Would send {$reminderType} reminder to {$member->full_name} for: {$task->description}");
                Log::info('DRY-RUN duty reminder SMS', [
                    'task_id' => $task->id,
                    'member_id' => $member->id,
                    'phone' => $member->telephone,
                    'type' => $reminderType,
                ]);
                $sentCount++;
                continue;
            }

            try {
                $ok = $smsService->sendSms($member->telephone, $message);
                if ($ok) {
                    Cache::put($cacheKey, true, now()->addDays(1));
                    $sentCount++;
                    Log::info('Duty reminder SMS sent', [
                        'task_id' => $task->id,
                        'phone' => $member->telephone,
                        'type' => $reminderType,
                    ]);
                }
            } catch (\Throwable $e) {
                Log::error('Error sending duty reminder: '.$e->getMessage(), [
                    'task_id' => $task->id,
                ]);
            }
        }

        $this->info("Duty reminders processed. Sent: {$sentCount}");
        return self::SUCCESS;
    }

    protected function buildMessage(MinuteActionItem $task, string $type): string
    {
        $memberName = $task->responsibleMember->full_name ?? 'Member';
        $desc = $task->description;
        $minuteTitle = $task->minute->title ?? 'Meeting';
        $dueDate = $task->due_date->format('d/m/Y');

        if ($type === 'TODAY') {
            return "REMINDER: Your duty \"$desc\" (from $minuteTitle) is DUE TODAY ($dueDate). Please update your progress in the app.";
        } elseif ($type === 'TOMORROW') {
            return "REMINDER: Your duty \"$desc\" (from $minuteTitle) is due TOMORROW ($dueDate).";
        } elseif ($type === 'OVERDUE') {
            return "OVERDUE TASK: Your duty \"$desc\" (from $minuteTitle) was due on $dueDate. Please complete it as soon as possible.";
        }

        return "REMINDER: You have an assigned task: \"$desc\". Please check the minutes app.";
    }
}
