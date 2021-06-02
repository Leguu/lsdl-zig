const std = @import("std");
const lsdl = @import("../lsdl.zig");

window: *lsdl.SDL_Window,

const Self = @This();

pub const WindowOpts = struct {
    title: [*c]const u8 = null,
    flags: []Flags = &[_]Flags{},

    pub const Flags = enum(u32) {
        fullscreen = lsdl.SDL_WINDOW_FULLSCREEN,
    };
};

pub fn new(s: lsdl.Size, opts: anytype) Self {
    var result: u32 = 0;
    for (opts.flags) |flag| {
        result = @enumToInt(flag) | result;
    }
    const window = lsdl.SDL_CreateWindow(opts.title, 0, 0, s.x, s.y, 0) orelse {
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
