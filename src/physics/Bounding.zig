const std = @import("std");
const lsdl = @import("../lsdl.zig");

boxes: []Box,

const Self = @This();

pub const Box = struct {
    pos: lsdl.Size,
    size: lsdl.Size,

    pub fn new(pos: lsdl.Size, size: lsdl.Size) @This() {
        return .{ .pos = pos, .size = size };
    }

    pub fn colliding(self: Self.Box, other: Self.Box) bool {
        if (self.pos.x < other.pos.x + other.size.x and
            self.pos.x + self.size.x > other.pos.x and
            self.pos.y < other.pos.y + other.size.y and
            self.pos.y + self.size.y > other.pos.y)
        // if (self.pos.x + self.size.x >= other.pos.x and
        //     self.pos.x <= other.pos.x + other.size.x and
        //     self.pos.y + self.size.y >= other.pos.y and
        //     self.pos.y <= other.pos.y + other.size.y)
        {
            return true;
        }
        return false;
    }
};

pub fn draw(self: Self, render: *lsdl.Render, pos: lsdl.Size) void {
    for (self.boxes) |box| {
        render.drawRectangleSize(pos.add(box.pos), box.size);
    }
}

pub fn new(boxes: []Box) Self {
    return .{ .boxes = boxes };
}

pub fn colliding(self: Self, other: Self) bool {
    for (self.boxes) |box| {
        for (other.boxes) |other_box| {
            if (box.colliding(other_box)) return true;
        }
    }
    return false;
}
