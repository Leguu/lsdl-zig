const std = @import("std");
const lsdl = @import("../lsdl.zig");

image: lsdl.Image,
sprite_size: lsdl.Size,
index_size: lsdl.Size,
length: i32,

const Self = @This();

/// sprite_size has to be the size in pixels of each sprite.
pub fn new(image: lsdl.Image, sprite_size: lsdl.Size) Self {
    const tsize = image.texture_size;
    const index_size = tsize.divide(sprite_size);

    return .{
        .image = image,
        .sprite_size = sprite_size,
        .index_size = index_size,
        .length = index_size.square(),
    };
}

/// indes_size is the number of frames in the spritesheet.
pub fn newIndex(image: lsdl.Image, index_size: lsdl.Size) Self {
    const sprite_size = image.texture_size.lossyCast(i32).divide(index_size);

    return .{
        .image = image,
        .sprite_size = sprite_size,
        .index_size = index_size,
        .length = index_size.square(),
    };
}

pub fn size(self: Self) lsdl.Vector(f32) {
    return self.sprite_size.lossyCast(f32).rescale(self.image.scale);
}

/// Get the position in the spritesheet at the index.
pub fn get(self: Self, index: i32) !lsdl.Size {
    if (index >= self.length) {
        return error.IndexOutOfBounds;
    }
    const x = self.sprite_size.x * @rem(index, self.index_size.x);
    const y = self.sprite_size.y * @divTrunc(index, self.index_size.x);
    return lsdl.Size.new(x, y);
}

pub fn draw(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32), index: i32, opts: lsdl.Image.Options) !void {
    var newOpts = opts;
    newOpts.srcpos = try self.get(index);
    newOpts.tsize = self.sprite_size;
    self.image.draw(render, pos, newOpts);
}
