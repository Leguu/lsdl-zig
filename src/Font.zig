const std = @import("std");
const lsdl = @import("lsdl.zig");

font: *lsdl.TTF_Font,
text: [*c]const u8 = null,
cache: ?lsdl.Image = null,

const Self = @This();

const TextOpts = struct {
    pos: lsdl.Vector(f32) = .{ .x = 0, .y = 0 },
    color: lsdl.Color = lsdl.Color.black,
    text: [*c]const u8 = null,
};

pub fn new(path: [*c]const u8, size: i32) Self {
    const font = lsdl.TTF_OpenFont(path, size);
    if (font == null) {
        lsdl.TTFError();
    }
    return Self{ .font = font.? };
}

pub fn draw(self: *Self, render: lsdl.Render, opts: TextOpts) void {
    // Check if the user passed text.
    if (opts.text != null) {
        // If we don't have text, or if the text is different, we will update the cache.
        if (self.text == null or std.cstr.cmp(self.text, opts.text) != 0) {
            self.text = opts.text;
            self.cache = self.create(render, self.text, opts.color);
        }
    }

    if (self.cache != null) {
        self.cache.?.draw(render, opts.pos, .{});
    } else {
        std.log.warn("No text is being rendered; no text was given", .{});
    }
}

pub fn deinit(self: Self) void {
    lsdl.TTF_CloseFont(self.font);
}

pub fn create(self: Self, render: lsdl.Render, text: [*c]const u8, color: lsdl.Color) lsdl.Image {
    const surface = lsdl.TTF_RenderText_Blended(self.font, text, .{ .r = color.red, .g = color.green, .b = color.blue, .a = color.alpha });
    return lsdl.Image.loadSurface(render, surface);
}
