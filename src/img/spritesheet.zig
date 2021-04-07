const std = @import("std");
const lsdl = @import("../lsdl.zig");

pub const Spritesheet = struct {
    image: lsdl.Image,
    sprite_size: SpriteSize,

    const SpriteSize = struct { height: usize, width: usize };

    const Self = @This();

    pub fn load(render: lsdl.Render, path: [*c]const u8, sprite_size: SpriteSize) Self {
        return .{ .image = lsdl.Image.load(render, path), .sprite_size = sprite_size };
    }

    pub fn length(self: *Self) usize {
        const size = self.image.size(usize);
        const width = size.width / self.sprite_size.width;
        const height = size.height / self.sprite_size.height;
        return width * height;
    }
};
