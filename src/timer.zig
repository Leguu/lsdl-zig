const std = @import("std");
const time = std.time;

const HashMap = std.hash_map.AutoHashMap(u64, u64);

pub const Timer = struct {
    timer: time.Timer,
    previous: HashMap = HashMap.init(std.heap.page_allocator),

    const Self = @This();

    pub fn new() !Self {
        return Self{ .timer = try time.Timer.start() };
    }

    /// Dictates whether the loop should do a frame.
    /// value must be in milliseconds per frame.
    pub fn doFrame(self: *Self, value: u64) bool {
        const now = self.timer.read();

        if (!self.previous.contains(value))
            self.previous.put(value, 0) catch unreachable;

        if (now - self.previous.get(value).? < value * time.ns_per_ms)
            return false;

        self.previous.put(value, now) catch unreachable;
        return true;
    }
};
