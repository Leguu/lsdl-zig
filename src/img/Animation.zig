const lsdl = @import("../lsdl.zig");
const std = @import("std");

spritesheet: lsdl.Spritesheet,
animation_length: u64,
accumulator: u64 = 0,
index: i32 = 0,

const Self = @This();

pub fn new(spritesheet: lsdl.Spritesheet, animation_length: u64) Self {
    return Self{
        .spritesheet = spritesheet,
        .animation_length = animation_length * std.time.ns_per_ms,
    };
}

pub fn load(image: lsdl.Image, sprite_size: lsdl.Size, animation_length: u64) Self {
    return new(lsdl.Spritesheet.new(image, sprite_size), animation_length);
}

pub fn tick(self: *Self, dt: u64) void {
    self.accumulator += dt;
}

pub fn drawFrame(self: *Self, render: lsdl.Render, pos: lsdl.Vector(f32), dt: u64, opts: lsdl.Image.Options) !void {
    try self.spritesheet.draw(render, pos, self.index, opts);

    if (self.accumulator < self.animation_length) {
        self.accumulator += dt;
        return;
    }

    self.accumulator -= self.animation_length;
    self.index += 1;

    if (self.index >= self.spritesheet.length) self.index = 0;
}
