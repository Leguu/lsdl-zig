const lsdl = @import("lsdl.zig");

test "core functionality" {
    _ = lsdl.core.Core.new(0, 0);
}

test "math functionality" {
    _ = lsdl.math.Vector(i32).zero();
}

test "timer functionality" {
    _ = try lsdl.timer.Timer.new();
}
