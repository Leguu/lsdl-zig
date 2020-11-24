const lsdl = @import("lsdl.zig");

pub const Input = struct {
    event: lsdl.SDL_Event = undefined,

    const Self = @This();

    pub fn new() Self {
        return Self{};
    }

    pub fn poll(self: *Self) bool {
        return lsdl.SDL_PollEvent(&self.event) == 1;
    }
};
