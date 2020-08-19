usingnamespace @cImport({
    @cInclude("SDL2/SDL.h");
});

const std = @import("std");
const testing = std.testing;

pub const LSDLCore = struct {
    window: *SDL_Window,
    renderer: *SDL_Renderer,

    window_width: i32,
    window_height: i32,

    pub fn new(width: i32, height: i32) LSDLCore {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        std.debug.panic("Error has occured.newializing SDL: {}\n", .{SDL_GetError()});
    }

    const window = SDL_CreateWindow(0, 0, 0, width, height, 0) orelse {
        std.debug.panic("Error has occured creating window: {}\n", .{SDL_GetError()});
    };

    const renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED) orelse {
        std.debug.panic("Error has occured creating renderer: {}\n", .{SDL_GetError()});
    };

    return LSDLCore { .window = window, .renderer = renderer };
    }
};

test "basic add functionality" {
    _ = LSDLCore.new(1000, 800);
}
