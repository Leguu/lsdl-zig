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

pub fn drawLine(self: Self, pos: lsdl.Vector(f32), target: lsdl.Vector(f32)) void {
    if (lsdl.SDL_RenderDrawLineF(self.renderer, pos.x, pos.y, target.x, target.y) < 0)
        lsdl.SDLError();
}

pub fn drawBoxSize(self: Self, box: lsdl.Box(i32)) void {
    const rectangle = lsdl.SDL_Rect{ .x = box.pos.x, .y = box.pos.y, .w = box.size.x, .h = box.size.y };
    if (lsdl.SDL_RenderDrawRect(self.renderer, &rectangle) < 0)
        lsdl.SDLError();
}

pub fn drawBox(self: Self, box: lsdl.Box(f32)) void {
    const rectangle = lsdl.SDL_FRect{ .x = box.pos.x, .y = box.pos.y, .w = box.size.x, .h = box.size.y };
    if (lsdl.SDL_RenderDrawRectF(self.renderer, &rectangle) < 0)
        lsdl.SDLError();
}

pub fn drawPoint(self: Self, pos: lsdl.Vector(f32)) void {
    if (lsdl.SDL_RenderDrawPointF(self.renderer, pos.x, pos.y) < 0)
        lsdl.SDLError();
}

pub fn setDrawColor(self: Self, color: Color) void {
    if (lsdl.SDL_SetRenderDrawColor(self.renderer, color.red, color.green, color.blue, color.alpha) < 0)
        lsdl.SDLError();
}

pub fn getColor(self: Self) Color {
    var color = Color.black;
    if (lsdl.SDL_GetRenderDrawColor(self.renderer, &color.red, &color.green, &color.blue, &color.alpha) < 0)
        lsdl.SDLError();
    return color;
}

/// Clears the screen with specified color.
/// Does not change current color.
pub fn clear(self: Self, color: Color) void {
    const old = self.getColor();
    self.setDrawColor(color);
    if (lsdl.SDL_RenderClear(self.renderer) < 0)
        lsdl.SDLError();
    self.setDrawColor(old);
}

pub fn present(self: Self) void {
    lsdl.SDL_RenderPresent(self.renderer);
}

/// Draw a circle using the Midpoint Circle Algorithm.
pub fn drawCircle(self: Self, pos: lsdl.Vector(f32), radius: f32) void {
    const diameter = radius * 2;

    var point = lsdl.Vector(f32).new(radius - 1, 0);
    var tx: f32 = 1;
    var ty: f32 = 1;
    var err = tx - diameter;

    while (point.x >= point.y) {
        self.drawPoint(lsdl.Vector(f32).new(pos.x + point.x, pos.y + point.y));
        self.drawPoint(lsdl.Vector(f32).new(pos.x - point.x, pos.y - point.y));
        self.drawPoint(lsdl.Vector(f32).new(pos.x - point.x, pos.y + point.y));
        self.drawPoint(lsdl.Vector(f32).new(pos.x + point.y, pos.y - point.x));
        self.drawPoint(lsdl.Vector(f32).new(pos.x + point.y, pos.y + point.x));
        self.drawPoint(lsdl.Vector(f32).new(pos.x - point.y, pos.y - point.x));
        self.drawPoint(lsdl.Vector(f32).new(pos.x - point.y, pos.y + point.x));
        self.drawPoint(lsdl.Vector(f32).new(pos.x + point.x, pos.y - point.y));

        if (err <= 0) {
            point.y += 1;
            err += ty;
            ty += 2;
        }

        if (err > 0) {
            point.x -= 1;
            tx += 2;
            err += tx - diameter;
        }
    }
}
