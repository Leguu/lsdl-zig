const std = @import("std");
const lsdl = @import("lsdl.zig");

font: *lsdl.TTF_Font,

const Self = @This();

pub fn new(path: [*c]const u8, size: i32) Self {
    const font = lsdl.TTF_OpenFont(path, size);
    if (font == null) {
        lsdl.TTFError();
    }
    return Self{
        .font = font.?,
    };
}

pub fn create(self: Self, render: lsdl.Render, text: [*c]const u8) lsdl.Image {
    const surface = lsdl.TTF_RenderText_Solid(self.font, text, .{.r=0, .g=0, .b=0, .a=255});
    return lsdl.Image.loadSurface(render, surface);
}

pub fn draw(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32), text: [*c]const u8) void {
    const image = self.create(render, text);
    image.draw(render, pos, .{});
}
