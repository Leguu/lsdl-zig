const std = @import("std");

const lsdl = @import("../lsdl.zig");
const Color = lsdl.Color;
const Window = lsdl.Window;

renderer: *lsdl.SDL_Renderer,

const Self = @This();

pub fn new(window: Window) Self {
    const renderer = lsdl.SDL_CreateRenderer(window.window, -1, lsdl.SDL_RENDERER_ACCELERATED) orelse {
        std.debug.panic("Error has occured creating renderer: {}\n", .{lsdl.SDL_GetError().*});
    };

    return Self{ .renderer = renderer };
}

pub fn drawLine(self: *Self, x: f32, y: f32, targetX: f32, targetY: f32) void {
    if (lsdl.SDL_RenderDrawLineF(self.renderer, x, y, targetX, targetY) < 0)
        lsdl.SDLError();
}

pub fn drawRectangleSize(self: *Self, pos: lsdl.Size, size: lsdl.Size) void {
    const rectangle = lsdl.SDL_Rect{ .x = pos.x, .y = pos.y, .w = size.x, .h = size.y };
    if (lsdl.SDL_RenderDrawRect(self.renderer, &rectangle) < 0)
        lsdl.SDLError();
}

pub fn drawRectangle(self: *Self, pos: lsdl.Vector(f32), size: lsdl.Vector(f32)) void {
    const rectangle = lsdl.SDL_FRect{ .x = pos.x, .y = pos.y, .w = size.x, .h = size.y };
    if (lsdl.SDL_RenderDrawRectF(self.renderer, &rectangle) < 0)
        lsdl.SDLError();
}

pub fn drawPoint(self: *Self, x: f32, y: f32) void {
    if (lsdl.SDL_RenderDrawPointF(self.renderer, x, y) < 0)
        lsdl.SDLError();
}

pub fn setDrawColor(self: *Self, color: Color) void {
    if (lsdl.SDL_SetRenderDrawColor(self.renderer, color.red, color.green, color.blue, color.alpha) < 0)
        lsdl.SDLError();
}

pub fn getColor(self: *Self) Color {
    var color = Color.black;
    if (lsdl.SDL_GetRenderDrawColor(self.renderer, &color.red, &color.green, &color.blue, &color.alpha) < 0)
        lsdl.SDLError();
    return color;
}

/// Clears the screen with specified color.
/// Does not change current color.
pub fn clear(self: *Self, color: Color) void {
    const old = self.getColor();
    self.setDrawColor(color);
    if (lsdl.SDL_RenderClear(self.renderer) < 0)
        lsdl.SDLError();
    self.setDrawColor(old);
}

pub fn present(self: *Self) void {
    lsdl.SDL_RenderPresent(self.renderer);
}

/// Draw a circle using the Midpoint Circle Algorithm.
pub fn drawCircle(self: *Self, centreX: f32, centreY: f32, radius: f32) void {
    const diameter = radius * 2;

    var x = radius - 1;
    var y: f32 = 0;
    var tx: f32 = 1;
    var ty: f32 = 1;
    var err = tx - diameter;

    while (x >= y) {
        self.drawPoint(centreX + x, centreY + y);
        self.drawPoint(centreX - x, centreY - y);
        self.drawPoint(centreX - x, centreY + y);
        self.drawPoint(centreX + y, centreY - x);
        self.drawPoint(centreX + y, centreY + x);
        self.drawPoint(centreX - y, centreY - x);
        self.drawPoint(centreX - y, centreY + x);
        self.drawPoint(centreX + x, centreY - y);

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
