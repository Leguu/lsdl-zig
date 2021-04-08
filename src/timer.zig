const std = @import("std");
const time = std.time;
const lsdl = @import("lsdl.zig");

/// A Struct for all time-dependent calulations.
/// Also provides functionality for FPS moderation.
pub const Timer = struct {
    timer: time.Timer,
    // previous: u64 = 0,
    accumulator: u64 = 0,

    const step: u64 = time.ns_per_ms * 16;

    const Self = @This();

    pub fn new() !Self {
        return Self{ .timer = try time.Timer.start() };
    }

    pub fn wait(self: *Self) void {
        if (self.accumulator < step)
            lsdl.SDL_Delay(@intCast(u32, (step - self.accumulator) / time.ns_per_ms));
    }

    /// Dictates whether the loop should do a frame.
    /// value must be in milliseconds per frame.
    pub fn doFrame(self: *Self) bool {
        if (self.accumulator >= step) {
            self.accumulator -= step;
            return true;
        }
        return false;
    }

    /// Delta-time in nanoseconds.
    pub fn deltaTime(self: *Self) u64 {
        return dt;
    }

    pub fn tick(self: *Self) void {
        //self.previous = self.timer.read();
        self.accumulator += self.timer.lap();
    }
};
