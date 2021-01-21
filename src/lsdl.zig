usingnamespace @cImport({
    @cInclude("SDL2/SDL.h");
});

pub const Input = @import("input.zig").Input;
pub const Vector = @import("vector.zig").Vector;
pub const Timer = @import("timer.zig").Timer;

pub const Core = @import("core/core.zig").Core;

const render = @import("core/render.zig");
pub const Color = render.Color;
pub const Render = render.Render;

pub const Scancode = @import("const/Scancode.zig").Scancode;
pub const Keycode = @import("const/Keycode.zig").Keycode;
pub const Keymod = @import("const/Keymod.zig").Keymod;

const std = @import("std");

pub fn SDLError() void {
    std.debug.panic("An SDL Error has Occured! Error code: {}\n", .{SDL_GetError().*});
}
