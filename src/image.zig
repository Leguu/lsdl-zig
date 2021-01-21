const std = @import("std");
const lsdl = @import("lsdl.zig");

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

    pub fn size(self: *const Self, comptime T: type) struct {
        width: T, height: T
    } {
        var width: i32 = 0;
        var height: i32 = 0;

        if (lsdl.SDL_QueryTexture(self.texture, 0, 0, &width, &height) < 0) lsdl.SDLError();

        return .{ .width = std.math.lossyCast(T, width), .height = std.math.lossyCast(T, height) };
    }

    pub fn draw(self: *const Self, render: lsdl.Render) void {
        if (lsdl.SDL_RenderCopy(render.renderer, self.texture, 0, 0) < 0) lsdl.SDLError();
    }

    pub fn drawScale(self: *const Self, render: lsdl.Render, pos: lsdl.Vector(f32), scale: f32) void {
        const tsize = self.size(f32);

        const rectangle = lsdl.SDL_FRect{
            .x = pos.x,
            .y = pos.y,
            .w = tsize.width * scale,
            .h = tsize.height * scale,
        };

        if (lsdl.SDL_RenderCopyF(render.renderer, self.texture, 0, &rectangle) < 0) lsdl.SDLError();
    }
};
