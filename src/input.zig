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
    return states[@intCast(usize, (scancode))] == 1;
}

pub const MouseState = enum(u32) { None, Left, Middle, Right };

pub fn mousePressed() MouseState {
    return @intToEnum(MouseState, lsdl.SDL_GetMouseState(0, 0));
}

pub fn mousePosition() Vector(i32) {
    var pos = Vector(i32).zero();
    _ = lsdl.SDL_GetMouseState(&pos.x, &pos.y);
    return pos;
}
