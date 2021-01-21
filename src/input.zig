//! Provides functionalities relating to SDL2's inputs.

const math = @import("std").math;

const lsdl = @import("lsdl.zig");
const Vector = lsdl.Vector;

pub fn poll() ?lsdl.SDL_Event {
    var event: lsdl.SDL_Event = undefined;
    if (lsdl.SDL_PollEvent(&event) == 1) {
        return event;
    } else {
        return null;
    }
}

pub fn keyboardPressed(scancode: lsdl.Scancode) bool {
    const states: [*c]const u8 = lsdl.SDL_GetKeyboardState(0);
    return states[@intCast(usize, @enumToInt(scancode))] == 1;
}

pub const MouseState = enum(u32) {
    None, Left, Middle, Right
};

pub fn mousePressed() MouseState {
    return @intToEnum(MouseState, lsdl.SDL_GetMouseState(0, 0));
}

pub fn mousePosition(comptime T: type) Vector(T) {
    var x: i32 = undefined;
    var y: i32 = undefined;
    _ = lsdl.SDL_GetMouseState(&x, &y);
    return Vector(T).new(math.lossyCast(T, x), math.lossyCast(T, y));
}
