const std = @import("std");
const lsdl = @import("../lsdl.zig");

boxes: []Box,
pos: lsdl.Vector(f32) = lsdl.Vector(f32).zero(),

const Self = @This();

pub const Box = struct {
    pos: lsdl.Vector(f32),
    size: lsdl.Vector(f32),
    absolute: *const lsdl.Vector(f32) = undefined,

    pub fn colliding(self: Self.Box, other: Self.Box) bool {
        if (self.absolute.x + self.pos.x + self.size.x >= other.absolute.x + other.pos.x and
            self.absolute.x + self.pos.x <= other.absolute.x + other.pos.x + other.size.x and
            self.absolute.y + self.pos.y + self.size.y >= other.absolute.y + other.pos.y and
            self.absolute.y + self.pos.y <= other.absolute.y + other.pos.y + other.size.y)
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
            if (box.colliding(other_box)) return true;
        }
    }
    return false;
}
