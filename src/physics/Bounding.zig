const std = @import("std");
const lsdl = @import("../lsdl.zig");

boxes: []Box,
pos: lsdl.Vector(f32),

pub const Box = lsdl.Box(f32);

const Self = @This();

pub fn draw(self: Self, render: lsdl.Render) void {
    for (self.boxes) |box| {
        render.drawBox(box.addPos(self.pos));
    }
}

pub fn new(pos: lsdl.Vector(f32), boxes: []Box) Self {
    return Self{ .pos = pos, .boxes = boxes };
}

pub fn colliding(self: Self, other: Self) bool {
    for (self.boxes) |box| {
        for (other.boxes) |other_box| {
            if (box.addPos(self.pos).intersecting(other_box.addPos(other.pos))) return true;
        }
    }
    return false;
}
