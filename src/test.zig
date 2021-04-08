const lsdl = @import("lsdl.zig");
const Scancode = lsdl.Scancode;
const Keycode = lsdl.Keycode;
const Keymod = lsdl.Keymod;

test "core functionality" {
    _ = lsdl.Core.new(lsdl.Size.zero());
}

test "math functionality" {
    _ = lsdl.Vector(i32).zero();
}

test "timer functionality" {
    _ = try lsdl.Timer.new();
}

test "input functionality" {
    _ = lsdl.input.keyboardPressed(lsdl.scancode.B);
    _ = lsdl.input.mousePressed();
}

test "keycodes" {
    const somekeycode = lsdl.keycode.a;
    const somescancode = lsdl.scancode.LEFT;
    const somekeymod = lsdl.keymod.CTRL;
}
