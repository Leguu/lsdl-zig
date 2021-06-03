const std = @import("std");
const lsdl = @import("../lsdl.zig");

window: *lsdl.SDL_Window,

const Self = @This();

pub const WindowOpts = struct {
    title: [*c]const u8 = null,
    size: lsdl.Size = .{ .x = 1000, .y = 1000 },
    flags: []const Flags = &.{},

    const Flags = enum(u32) {
        fullscreen = lsdl.SDL_WINDOW_FULLSCREEN,
        fullscreen_desktop = lsdl.SDL_WINDOW_FULLSCREEN_DESKTOP,
        opengl = lsdl.SDL_WINDOW_OPENGL,
        vulkan = lsdl.SDL_WINDOW_VULKAN,
        metal = lsdl.SDL_WINDOW_METAL,
        hidden = lsdl.SDL_WINDOW_HIDDEN,
        borderless = lsdl.SDL_WINDOW_BORDERLESS,
        resizable = lsdl.SDL_WINDOW_RESIZABLE,
        minimized = lsdl.SDL_WINDOW_MINIMIZED,
        maximized = lsdl.SDL_WINDOW_MAXIMIZED,
        input_grabbed = lsdl.SDL_WINDOW_INPUT_GRABBED,
        highdpi = lsdl.SDL_WINDOW_ALLOW_HIGHDPI,
    };
};

pub fn new(opts: WindowOpts) Self {
    var result: u32 = 0;
    for (opts.flags) |flag| {
        result = @enumToInt(flag) | result;
    }

    const window = lsdl.SDL_CreateWindow(opts.title, 0, 0, opts.size.x, opts.size.y, result) orelse {
        std.debug.panic("Error has occured creating window: {}\n", .{lsdl.SDL_GetError().*});
    };

    return Self{ .window = window };
}

/// Get the current window size as a struct.
pub fn size(self: *Self) lsdl.Size {
    var tsize = lsdl.Size.zero();

    lsdl.SDL_GetWindowSize(self.window, &tsize.x, &tsize.y);

    return tsize;
}
