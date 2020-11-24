const std = @import("std");
const testing = std.testing;

const lsdl = @import("lsdl.zig");

pub const Core = struct {
    window: *lsdl.SDL_Window,
    renderer: *lsdl.SDL_Renderer,

    window_width: i32,
    window_height: i32,

    const Self = @This();

    pub fn new(width: i32, height: i32) Self {
        if (lsdl.SDL_Init(lsdl.SDL_INIT_VIDEO) != 0) {
            std.debug.panic("Error has occured initializing SDL: {}\n", .{lsdl.SDL_GetError()});
        }

        const window = lsdl.SDL_CreateWindow(0, 0, 0, width, height, 0) orelse {
            std.debug.panic("Error has occured creating window: {}\n", .{lsdl.SDL_GetError()});
        };

        const renderer = lsdl.SDL_CreateRenderer(window, -1, lsdl.SDL_RENDERER_ACCELERATED) orelse {
            std.debug.panic("Error has occured creating renderer: {}\n", .{lsdl.SDL_GetError()});
        };

        return Self{ .window = window, .renderer = renderer, .window_width = width, .window_height = height };
    }
};
