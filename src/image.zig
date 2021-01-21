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

    pub fn draw(self: *const Self, render: lsdl.Render) void {
        if (lsdl.SDL_RenderCopy(render.renderer, self.texture, 0, 0) < 0) lsdl.SDLError();
    }
};
