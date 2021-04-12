const lsdl = @import("../lsdl.zig");

spritesheet: lsdl.Spritesheet,
animation_length: u64,
accumulator: u64 = 0,
index: i32 = 0,

const Self = @This();

pub fn new(spritesheet: lsdl.Spritesheet, animation_length: u64) Self {
    return Self {
        .spritesheet = spritesheet,
        .animation_length = animation_length,
    };
}

pub fn load(image: lsdl.Image, sprite_size: lsdl.Size, animation_length: u64) Self {
    return Self {
        .spritesheet = lsdl.Spritesheet.new(image, sprite_size),
        .animation_length = animation_length,
    };
}

pub fn tick(self: *Self, dt: u64) void {
    self.accumulator += dt;
}

pub fn drawFrame(self: *Self, render: lsdl.Render, pos: lsdl.Vector(f32), dt: u64) !void {
    if (self.accumulator < self.animation_length) {
        self.accumulator += dt;
        return;
    }

    if (self.index > self.spritesheet.length) self.index = 0;

    try self.spritesheet.draw(render, pos, self.index);
    self.accumulator -= self.animation_length;
    self.index += 1;
}
