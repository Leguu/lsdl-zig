const lsdl = @import("lsdl.zig");

pub const Input = struct {
    const Self = @This();

    pub fn new() Self {
        return Self{};
    }

    pub fn poll(self: *Self) ?lsdl.SDL_Event {
        var event: lsdl.SDL_Event = undefined;
        if (lsdl.SDL_PollEvent(&event) == 1) {
            return event;
        } else {
            return null;
        }
    }
};
