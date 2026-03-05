<?php

namespace App\Events;

use App\Models\Announcement;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AnnouncementCreated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $announcement;

    /**
     * Create a new event instance.
     */
    public function __construct(Announcement $announcement)
    {
        $this->announcement = $announcement->load(['sender', 'recipient']);
    }

    /**
     * Get the channels the event should broadcast on.
     */
    public function broadcastOn(): array
    {
        $channels = [];
        
        // If it's an individual message, broadcast to the recipient's user channel
        if ($this->announcement->type === 'individual' && $this->announcement->recipient_id) {
            // Find the User ID associated with this Member recipient
            $recipientMember = $this->announcement->recipient;
            if ($recipientMember) {
                $user = \App\Models\User::where('email', $recipientMember->email)->first();
                if ($user) {
                    $channels[] = new PrivateChannel('App.Models.User.' . $user->id);
                }
            }
        } elseif ($this->announcement->type === 'broadcast') {
            // For broadcast messages, broadcast to all authenticated users
            $channels[] = new Channel('announcements');
        }
        
        return $channels;
    }

    /**
     * The event's broadcast name.
     */
    public function broadcastAs(): string
    {
        return 'announcement.created';
    }

    /**
     * Get the data to broadcast.
     */
    public function broadcastWith(): array
    {
        return [
            'id' => $this->announcement->id,
            'title' => $this->announcement->title,
            'message' => $this->announcement->message,
            'type' => $this->announcement->type,
            'sent_by' => $this->announcement->sent_by,
            'recipient_id' => $this->announcement->recipient_id,
            'is_priority' => $this->announcement->is_priority,
            'created_at' => $this->announcement->created_at,
            'sender' => $this->announcement->sender ? [
                'id' => $this->announcement->sender->id,
                'name' => $this->announcement->sender->full_name,
                'profile_image' => $this->announcement->sender->profile_image,
            ] : null,
        ];
    }
}






