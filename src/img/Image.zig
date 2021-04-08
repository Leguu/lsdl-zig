const std = @import("std");
const lsdl = @import("../lsdl.zig");

texture: *lsdl.SDL_Texture,
texture_size: lsdl.Size,
size: lsdl.Vector(f32),

const Self = @This();

pub fn load(render: lsdl.Render, path: [*c]const u8) Self {
    const surface = lsdl.IMG_Load(path);
    if (surface == 0) lsdl.IMGError();

    const texture = lsdl.SDL_CreateTextureFromSurface(render.renderer, surface);
    if (texture == null) lsdl.SDLError();

    lsdl.SDL_FreeSurface(surface);

    var tsize = lsdl.Size.zero();
    if (lsdl.SDL_QueryTexture(texture, 0, 0, &tsize.x, &tsize.y) < 0) lsdl.SDLError();

    return Self{
        .texture = texture.?,
        .texture_size = tsize,
        .size = tsize.lossyCast(f32),
    };
}

pub fn loadScale(render: lsdl.Render, path: [*c]const u8, scale: f32) Self {
    var self = load(render, path);
    self.setScale(scale);
    return self;
}

pub fn setScale(self: *Self, scale: f32) void {
    self.size = self.size.rescale(scale);
}

pub fn draw(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32)) void {
    const rectangle = lsdl.SDL_FRect{ .x = pos.x, .y = pos.y, .w = self.size.x, .h = self.size.y };

    if (lsdl.SDL_RenderCopyF(render.renderer, self.texture, 0, &rectangle) < 0) lsdl.SDLError();
}

pub fn drawPart(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32), srcpos: lsdl.Size, tsize: lsdl.Size) void {
    const src = lsdl.SDL_Rect{ .x = srcpos.x, .y = srcpos.y, .w = tsize.x, .h = tsize.y };
    const dest = lsdl.SDL_FRect{ .x = pos.x, .y = pos.y, .w = self.size.x, .h = self.size.x };

    if (lsdl.SDL_RenderCopyF(render.renderer, self.texture, &src, &dest) < 0) lsdl.SDLError();
}
