<?php

namespace App\Http\Controllers\Elder;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    /**
     * Get attendance records for elders (e.g. Holy Communion history).
     * Same data as admin attendance - filtered by date range and optional event_type.
     */
    public function getAttendance(Request $request)
    {
        try {
            $startDate = $request->input('start_date');
            $endDate = $request->input('end_date');
            $eventType = $request->input('event_type');

            $query = Attendance::query();

            if ($startDate) {
                $query->whereDate('event_date', '>=', $startDate);
            }

            if ($endDate) {
                $query->whereDate('event_date', '<=', $endDate);
            }

            if (!$startDate && !$endDate && !$eventType) {
                $query->whereDate('event_date', now()->toDateString());
            }

            $records = $query->when($eventType, function ($q) use ($eventType) {
                return $q->where('event_type', $eventType);
            })
                ->orderBy('scanned_at', 'desc')
                ->get();

            return response()->json([
                'status' => 200,
                'message' => 'Attendance records retrieved',
                'data' => $records,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 500,
                'message' => 'Failed to retrieve attendance',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
