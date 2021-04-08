const std = @import("std");
const lsdl = @import("../lsdl.zig");

pub const Image = struct {
    texture: *lsdl.SDL_Texture,

    const Self = @This();

    pub fn load(render: lsdl.Render, path: [*c]const u8) Self {
        const surface = lsdl.IMG_Load(path);
        if (surface == 0) lsdl.IMGError();

        const texture = lsdl.SDL_CreateTextureFromSurface(render.renderer, surface);
        if (texture == null) lsdl.SDLError();

        lsdl.SDL_FreeSurface(surface);

        return Self{ .texture = texture.? };
    }

    pub fn size(self: *const Self) lsdl.Size {
        var tsize = lsdl.Size.zero();

        if (lsdl.SDL_QueryTexture(self.texture, 0, 0, &tsize.x, &tsize.y) < 0) lsdl.SDLError();

        return tsize;
    }

    pub fn draw(self: *const Self, render: lsdl.Render) void {
        if (lsdl.SDL_RenderCopy(render.renderer, self.texture, 0, 0) < 0) lsdl.SDLError();
    }

    pub fn drawScale(self: *const Self, render: lsdl.Render, pos: lsdl.Vector(f32), scale: f32) void {
        const tsize = self.size().lossyCast(f32);

        const rectangle = lsdl.SDL_FRect{
            .x = pos.x,
            .y = pos.y,
            .w = tsize.x * scale,
            .h = tsize.y * scale,
        };

        if (lsdl.SDL_RenderCopyF(render.renderer, self.texture, 0, &rectangle) < 0) lsdl.SDLError();
    }

    pub fn drawPart(self: *const Self, render: lsdl.Render, pos: lsdl.Vector(f32), srcpos: lsdl.Size, tsize: lsdl.Size) void {
        const src = lsdl.SDL_Rect{
            .x = srcpos.x,
            .y = srcpos.y,
            .w = tsize.x,
            .h = tsize.y,
        };

        const dest = lsdl.SDL_FRect{
            .x = pos.x,
            .y = pos.y,
            .w = @intToFloat(f32, tsize.x),
            .h = @intToFloat(f32, tsize.y),
        };

        if (lsdl.SDL_RenderCopyF(render.renderer, self.texture, &src, &dest) < 0) lsdl.SDLError();
    }
};
