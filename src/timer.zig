const std = @import("std");
const time = std.time;

pub const Timer = struct {
    timer: time.Timer,
    previous: u64 = 0,

    const Self = @This();

    pub fn new() !Self {
        return Self{ .timer = try time.Timer.start() };
    }

    /// Dictates whether the loop should do a frame.
    /// value must be in milliseconds per frame.
    pub fn doFrame(self: *Self, value: anytype) bool {
        const fpns = @floatToInt(u64, time.ns_per_s / value);

        return self.timer.read() - self.previous > fpns;
    }

    // Delta-time in nanoseconds
    pub fn deltaTime(self: *Self, comptime T: type) T {
        const dt = self.timer.read() - self.previous;
        return std.math.lossyCast(T, dt);
    }

    pub fn tick(self: *Self) void {
        self.previous = self.timer.read();
    }
};
