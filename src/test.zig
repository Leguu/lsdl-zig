const lsdl = @import("lsdl.zig");
const Scancode = lsdl.Scancode;
const Keycode = lsdl.Keycode;
const Keymod = lsdl.Keymod;

test "core functionality" {
    _ = lsdl.Core.new(0, 0);
}

test "math functionality" {
    _ = lsdl.Vector(i32).zero();
}

test "timer functionality" {
    _ = try lsdl.Timer.new();
}

test "input functionality" {
    _ = lsdl.Input.keyboardPressed(Scancode.B);
    _ = lsdl.Input.mousePressed();
}

test "keycodes" {
    const somekeycode = Keycode.a;
    const somescancode = Scancode.LEFT;
    const somekeymod = Keymod.CTRL;
}
