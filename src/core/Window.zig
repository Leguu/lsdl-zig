const std = @import("std");
const lsdl = @import("../lsdl.zig");

window: *lsdl.SDL_Window,

const Self = @This();

pub fn new(s: lsdl.Size) Self {
    const window = lsdl.SDL_CreateWindow(0, 0, 0, s.x, s.y, 0) orelse {
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
