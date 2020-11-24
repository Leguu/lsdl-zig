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
        lsdl.SDL_RenderDrawLineF(self.renderer, x, y, targetX, targetY);
    }

    pub fn drawPoint(self: *Self, x: f32, y: f32) void {
        lsdl.SDL_RenderDrawPointF(self.renderer, x, y);
    }

    pub fn setDrawColor(self: *Self, alpha: u32, red: u32, green: u32, blue: u32) void {
        lsdl.SDL_SetRenderDrawColor(self.renderer, alpha, red, green, blue);
    }

    pub fn clear(self: *Self) void {
        lsdl.SDL_RenderClear(self.renderer);
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
