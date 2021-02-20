const std = @import("std");
const lsdl = @import("../lsdl.zig");

pub const Spritesheet = struct {
    image: lsdl.Image,
    sprite_size: struct { height: u32, width: u32 },

    const Self = @This();

    pub fn length(self: *Self) usize {
        const size = self.image.size(usize);
        return 0;
    }
};
