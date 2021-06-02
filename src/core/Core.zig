//! The "core" of all lsdl functionality.
//! This is where you'll access most of the utilities provided by this library.
//! Initialize this struct to begin using the library!

const std = @import("std");
const testing = std.testing;

const lsdl = @import("../lsdl.zig");
const Window = lsdl.Window;
const Render = lsdl.Render;

window: Window,
render: Render,

const Self = @This();

pub fn new( opts: Window.WindowOpts) Self {
    if (lsdl.SDL_Init(lsdl.SDL_INIT_VIDEO) != 0) {
        std.debug.panic("Error has occured initializing SDL: {}\n", .{lsdl.SDL_GetError().*});
    }

    _ = lsdl.IMG_Init(lsdl.IMG_INIT_PNG);

    if (lsdl.TTF_Init() == -1) lsdl.TTFError();

    const window = Window.new(opts);

    const render = Render.new(window);

    return Self{
        .window = window,
        .render = render,
    };
}

pub fn cleanup(self: *Self) void {
    lsdl.SDL_DestroyRenderer(self.render.renderer);
    lsdl.SDL_DestroyWindow(self.window.window);
    lsdl.SDL_Quit();
    lsdl.IMG_Quit();
}
