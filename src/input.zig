const math = @import("std").math;

const lsdl = @import("lsdl.zig");
const Vector = lsdl.Vector;

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

    pub fn mouse_pressed(self: *Self) bool {
        return lsdl.SDL_GetMouseState(0, 0) == 1;
    }

    pub fn mouse_position(self: *Self, comptime T: type) Vector(T) {
        var x: i32 = undefined;
        var y: i32 = undefined;
        _ = lsdl.SDL_GetMouseState(&x, &y);
        return Vector(T).new(math.lossyCast(T, x), math.lossyCast(T, y));
    }
};
