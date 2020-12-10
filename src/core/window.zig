const std = @import("std");
const lsdl = @import("../lsdl.zig");

pub const Window = struct {
    window: *lsdl.SDL_Window,

    const Self = @This();

    pub fn new(window_width: i32, window_height: i32) Self {
        const window = lsdl.SDL_CreateWindow(0, 0, 0, window_width, window_height, 0) orelse {
            std.debug.panic("Error has occured creating window: {}\n", .{lsdl.SDL_GetError()});
        };

        return Self{ .window = window };
    }

    pub fn size(self: *Self) struct {
        width: i32, height: i32
    } {
        var width: i32 = 0;
        var height: i32 = 0;

        lsdl.SDL_GetWindowSize(self.window, &width, &height);

        return .{ .width = width, .height = height };
    }
};
