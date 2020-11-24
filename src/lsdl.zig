usingnamespace @cImport({
    @cInclude("SDL2/SDL.h");
});

pub const core = @import("core.zig");
pub const timer = @import("timer.zig");
pub const render = @import("render.zig");
pub const math = @import("math.zig");
pub const input = @import("input.zig");
