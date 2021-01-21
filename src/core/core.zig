const std = @import("std");
const testing = std.testing;

const lsdl = @import("../lsdl.zig");

const Window = @import("window.zig").Window;
const Render = @import("render.zig").Render;

/// The "core" of all lsdl functionality.
/// This is where you'll access most of the utilities provided by this library.
/// Initialize this struct to begin using the library!
pub const Core = struct {
    window: Window,
    render: Render,

    pub const input = lsdl.Input;

    const Self = @This();

    pub fn new(width: i32, height: i32) Self {
        if (lsdl.SDL_Init(lsdl.SDL_INIT_VIDEO) != 0) {
            std.debug.panic("Error has occured initializing SDL: {}\n", .{lsdl.SDL_GetError()});
        }

        const window = Window.new(width, height);

        const render = Render.new(window);

        return Self{
            .window = window,
            .render = render,
        };
    }
};
