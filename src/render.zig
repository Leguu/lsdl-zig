const lsdl = @import("lsdl.zig");

pub const Renderer = struct {
    renderer: *lsdl.SDL_Renderer,

    const Self = @This();

    pub fn new(renderer: *lsdl.SDL_Renderer) Self {
        return Self{ .renderer = renderer };
    }

    pub fn drawCircle(self: *Self, centreX: f32, centreY: f32, radius: f32) void {
        lsdl.render.RenderDrawCircleF(self.renderer, centreX, centreY, radius);
    }

    pub fn drawLine(self: *Self, x: f32, y: f32, targetX: f32, targetY: f32) void {
        if (lsdl.SDL_RenderDrawLineF(self.renderer, x, y, targetX, targetY) < 0)
            lsdl.SDLError();
    }

    pub fn drawPoint(self: *Self, x: f32, y: f32) void {
        if (lsdl.SDL_RenderDrawPointF(self.renderer, x, y) < 0)
            lsdl.SDLError();
    }

    pub fn setDrawColor(self: *Self, red: u8, green: u8, blue: u8, alpha: u8) void {
        if (lsdl.SDL_SetRenderDrawColor(self.renderer, red, green, blue, alpha) < 0)
            lsdl.SDLError();
    }

    pub fn clear(self: *Self, red: u8, green: u8, blue: u8, alpha: u8) void {
        var old_red: u8 = undefined;
        var old_green: u8 = undefined;
        var old_blue: u8 = undefined;
        var old_alpha: u8 = undefined;
        if (lsdl.SDL_GetRenderDrawColor(self.renderer, &old_red, &old_green, &old_blue, &old_alpha) < 0)
            lsdl.SDLError();

        self.setDrawColor(red, green, blue, alpha);
        if (lsdl.SDL_RenderClear(self.renderer) < 0)
            lsdl.SDLError();
        self.setDrawColor(old_red, old_green, old_blue, old_alpha);
    }

    pub fn present(self: *Self) void {
        lsdl.SDL_RenderPresent(self.renderer);
    }
};

/// Draw a circle using the Midpoint Circle Algorithm.
fn RenderDrawCircleF(renderer: *lsdl.SDL_Renderer, centreX: f32, centreY: f32, radius: f32) void {
    const diameter = radius * 2;

    var x = radius - 1;
    var y: f32 = 0;
    var tx: f32 = 1;
    var ty: f32 = 1;
    var err = tx - diameter;

    while (x >= y) {
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX + x, centreY - y);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX + x, centreY + y);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX - x, centreY - y);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX - x, centreY + y);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX + y, centreY - x);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX + y, centreY + x);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX - y, centreY - x);
        _ = lsdl.SDL_RenderDrawPointF(renderer, centreX - y, centreY + x);

        if (err <= 0) {
            y += 1;
            err += ty;
            ty += 2;
        }

        if (err > 0) {
            x -= 1;
            tx += 2;
            err += tx - diameter;
        }
    }
}
