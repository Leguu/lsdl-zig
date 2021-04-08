const std = @import("std");
const lsdl = @import("../lsdl.zig");

pub const Spritesheet = struct {
    image: lsdl.Image,
    sprite_size: lsdl.Size,
    width: usize,
    height: usize,
    length: usize,

    const Self = @This();

    /// sprite_size has to be the size in pixels of each sprite
    /// TODO: Allow non-pixel measures for sprites?
    pub fn load(render: lsdl.Render, path: [*c]const u8, sprite_size: lsdl.Size) Self {
        const image = lsdl.Image.load(render, path);
        const size = image.size();
        const width = @divExact(size.x, sprite_size.x);
        const height = @divExact(size.y, sprite_size.y);

        return .{
            .image = image,
            .sprite_size = sprite_size,
            .width = @intCast(usize, width),
            .height = @intCast(usize, height),
            .length = @intCast(usize, width * height),
        };
    }

    /// Get the position in the spritesheet at the index
    pub fn get(self: *const Self, index: usize) !lsdl.Size {
        if (index > self.length) {
            return error.IndexOutOfBounds;
        }
        const x = (index % self.width) * @intCast(usize, self.sprite_size.x);
        const y = @divTrunc(index, self.width) * @intCast(usize, self.sprite_size.y);
        return lsdl.Size.new(@intCast(i32, x), @intCast(i32, y));
    }

    pub fn draw(self: *const Self, render: lsdl.Render, pos: lsdl.Vector(f32), index: usize) !void {
        self.image.drawPart(render, pos, try self.get(index), self.sprite_size);
    }
};
