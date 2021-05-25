//! The main lsdl library file. Import this for your use.

// All C Imports, in case you need to use them.
usingnamespace @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL_ttf.h");
    @cInclude("SDL2/SDL_image.h");
});

/// Size for various constructs
pub const Size = Vector(i32);

//
// Core and engine
//
pub const Core = @import("core/Core.zig");

pub const Vector = @import("math/vector.zig").Vector;
pub const Timer = @import("Timer.zig");
pub const Bounding = @import("physics/Bounding.zig");

//
// Visuals
//
pub const Window = @import("core/Window.zig");
pub const Render = @import("core/Render.zig");
pub const Color = @import("Color.zig");
pub const Font = @import("Font.zig");

pub const Image = @import("img/Image.zig");
pub const Spritesheet = @import("img/Spritesheet.zig");
pub const Animation = @import("img/Animation.zig");

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

pub fn TTFError() void {
    std.debug.panic("A TTF Error has Occured! Error code: {}\n", .{TTF_GetError().*});
}

pub fn bound(value: anytype, start: anytype, end: anytype) @TypeOf(value, start, end) {
    return if (start <= value and value <= end) value else if (value < start) start else end;
}
