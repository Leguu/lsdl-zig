const std = @import("std");
const lsdl = @import("../lsdl.zig");

boxes: []Box,
pos: lsdl.Vector(f32) = lsdl.Vector(f32).zero(),

const Self = @This();

pub const Box = struct {
    pos: lsdl.Vector(f32),
    size: lsdl.Vector(f32),
    absolute: *const lsdl.Vector(f32) = undefined,

    pub fn colliding(self: Self.Box, other: Self.Box, self_absolute: lsdl.Vector(f32), other_absolute: lsdl.Vector(f32)) bool {
        if (self_absolute.x + self.pos.x + self.size.x >= other_absolute.x + other.pos.x and
            self_absolute.x + self.pos.x <= other_absolute.x + other.pos.x + other.size.x and
            self_absolute.y + self.pos.y + self.size.y >= other_absolute.y + other.pos.y and
            self_absolute.y + self.pos.y <= other_absolute.y + other.pos.y + other.size.y)
        {
            return true;
        }
        return false;
    }
};

pub fn draw(self: Self, render: *lsdl.Render) void {
    for (self.boxes) |box| {
        render.drawRectangle(self.pos.add(box.pos), box.size);
    }
}

pub fn new(pos: lsdl.Vector(f32), boxes: []Box) Self {
    const self = Self{ .pos = pos, .boxes = boxes };
    for (self.boxes) |*box| {
        box.absolute = &self.pos;
    }
    return self;
}

pub fn colliding(self: Self, other: Self) bool {
    for (self.boxes) |box| {
        for (other.boxes) |other_box| {
            if (box.colliding(other_box, self.pos, other.pos)) return true;
        }
    }
    return false;
}
