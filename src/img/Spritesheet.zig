const std = @import("std");
const lsdl = @import("../lsdl.zig");

image: lsdl.Image,
sprite_size: lsdl.Size,
index_size: lsdl.Size,
length: i32,

const Self = @This();

/// sprite_size has to be the size in pixels of each sprite
/// TODO: Allow non-pixel measures for sprites?
pub fn new(image: lsdl.Image, sprite_size: lsdl.Size) Self {
    const size = image.texture_size.lossyCast(i32);
    const index_size = size.divide(sprite_size);

    return .{
        .image = image,
        .sprite_size = sprite_size,
        .index_size = index_size,
        .length = index_size.square(),
    };
}

/// Get the position in the spritesheet at the index
pub fn get(self: Self, index: i32) !lsdl.Size {
    if (index >= self.length) {
        return error.IndexOutOfBounds;
    }
    const x = self.sprite_size.x * @rem(index, self.index_size.x);
    const y = self.sprite_size.y * @divTrunc(index, self.index_size.x);
    return lsdl.Size.new(x, y);
}

pub fn draw(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32), index: i32) !void {
    self.image.drawPart(render, pos, try self.get(index), self.sprite_size);
}
