const lsdl = @import("../lsdl.zig");

pub fn Box(comptime T: type) type {
    return struct {
        const Vector = lsdl.Vector(T);

        pos: Vector,
        size: Vector,

        const Self = @This();

        pub fn addPos(self: Self, other: Vector) Self {
            return Self{ .pos = self.pos.add(other), .size = self.size };
        }

        pub fn intersecting(self: Self, other: Self) bool {
            return self.end().x >= other.pos.x and
                self.pos.x <= other.end().x and
                self.end().y >= other.pos.y and
                self.pos.y <= other.end().y;
        }

        pub fn end(self: Self) Vector {
            return self.pos.add(self.size);
        }

        pub fn lossyCast(self: Self, comptime T: type) Box(T) {
            return Box(T){
                .pos = self.pos.lossyCast(T),
                .size = self.size.lossyCast(T),
            };
        }
    };
}
