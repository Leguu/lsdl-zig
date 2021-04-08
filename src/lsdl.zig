//! The main lsdl library file. Import this for your use.

// All C Imports, in case you need to use them.
usingnamespace @cImport({
    @cInclude("SDL2/SDL_image.h");
    @cInclude("SDL2/SDL.h");
});

/// Size for various constructs
pub const Size = Vector(i32);

//
// Core and engine
//
pub const Core = @import("core/core.zig").Core;

pub const Vector = @import("vector.zig").Vector;
pub const Timer = @import("timer.zig").Timer;

//
// Visuals
//
pub const Render = @import("core/render.zig").Render;
pub const Color = @import("color.zig").Color;

pub const Image = @import("img/image.zig").Image;
pub const Spritesheet = @import("img/spritesheet.zig").Spritesheet;

//
// Constants and input
//
pub const input = @import("input.zig");
pub const events = @import("const/events.zig");

pub const scancode = @import("const/scancode.zig");
pub const Scancode = usize;

pub const keycode = @import("const/keycode.zig");
pub const Keycode = usize;

pub const keymod = @import("const/keymod.zig");
pub const Keymod = usize;

//
// Utility functions
//
const std = @import("std");

pub fn SDLError() void {
    std.debug.panic("An SDL Error has Occured! Error code: {}\n", .{SDL_GetError().*});
}

pub fn IMGError() void {
    std.debug.panic("An Image Error has Occured! Error code: {}\n", .{IMG_GetError().*});
}
