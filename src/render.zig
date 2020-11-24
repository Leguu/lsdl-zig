const lsdl= @import("lsdl.zig");

/// Draw a circle using the Midpoint Circle Algorithm.
pub fn RenderDrawCircleF(renderer: *lsdl.SDL_Renderer, centreX: f32, centreY: f32, radius: f32) void {
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
