const std = @import("std");
const lsdl = @import("../lsdl.zig");

texture: *lsdl.SDL_Texture,
texture_size: lsdl.Size,
/// The image's scale when drawing
scale: f32 = 1,

const Self = @This();

pub const Options = struct {
    flip: lsdl.SDL_RendererFlip = .SDL_FLIP_NONE,
    angle: f32 = 0,
    srcpos: ?lsdl.Size = null,
    tsize: ?lsdl.Size = null,
};

pub fn loadSurface(render: lsdl.Render, surface: *lsdl.SDL_Surface) Self {
    const texture = lsdl.SDL_CreateTextureFromSurface(render.renderer, surface);
    if (texture == null) lsdl.SDLError();

    lsdl.SDL_FreeSurface(surface);

    var tsize = lsdl.Size.zero();
    if (lsdl.SDL_QueryTexture(texture, 0, 0, &tsize.x, &tsize.y) < 0) lsdl.SDLError();

    return Self{
        .texture = texture.?,
        .texture_size = tsize,
    };
}

pub fn load(render: lsdl.Render, path: [*c]const u8) Self {
    const surface = lsdl.IMG_Load(path);
    if (surface == 0) lsdl.IMGError();

    return loadSurface(render, surface);
}

pub fn loadScale(render: lsdl.Render, path: [*c]const u8, scale: f32) Self {
    var self = load(render, path);
    self.scale = scale;
    return self;
}

pub fn size(self: Self) lsdl.Vector(f32) {
    return self.texture_size.lossyCast(f32).rescale(self.scale);
}

/// General draw function.
pub fn draw(self: Self, render: lsdl.Render, pos: lsdl.Vector(f32), opts: Options) void {
    var src: ?lsdl.SDL_Rect = null;
    var dest = lsdl.SDL_FRect{ .x = pos.x, .y = pos.y, .w = self.size().x, .h = self.size().y };

    // Determines whether to print out a part of the image
    if ((opts.srcpos == null) != (opts.tsize == null)) {
        @panic("Options have to include tsize and srcpos at the same time, or not at all.");
    } else if (opts.srcpos != null and opts.tsize != null) {
        const tsize_cast = opts.tsize.?.lossyCast(f32).rescale(self.scale);
        src = lsdl.SDL_Rect{ .x = opts.srcpos.?.x, .y = opts.srcpos.?.y, .w = opts.tsize.?.x, .h = opts.tsize.?.y };
        dest.w = tsize_cast.x;
        dest.h = tsize_cast.y;
    }

    if (lsdl.SDL_RenderCopyExF(render.renderer, self.texture, if (src != null) &src.? else null, &dest, opts.angle, null, opts.flip) < 0) {
        lsdl.SDLError();
    }
}
