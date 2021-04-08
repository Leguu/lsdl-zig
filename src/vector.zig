const std = @import("std");
const math = std.math;
const testing = std.testing;

/// A simple 2-dimensional Vector type.
pub fn Vector(comptime T: type) type {
    return struct {
        x: T,
        y: T,

        const Self = @This();

        pub fn zero() Self {
            return Self{ .x = 0, .y = 0 };
        }

        pub fn new(x: T, y: T) Self {
            return Self{ .x = x, .y = y };
        }

        pub fn set(self: *Self, x: T, y: T) void {
            self.x = x;
            self.y = y;
        }

        pub fn add(self: Self, other: Self) Self {
            return new(self.x + other.x, self.y + other.y);
        }

        pub fn subtract(self: Self, other: Self) Self {
            return new(self.x - other.x, self.y - other.y);
        }

        /// Note: Not true vector multiplication.
        pub fn multiply(self: Self, other: Self) Self {
            return new(self.x * other.x, self.y * other.y);
        }

        pub fn divide(self: Self, other: Self) Self {
            return new(self.x / other.x, self.y / other.y);
        }

        pub fn rescale(self: Self, amount: T) Self {
            return new(self.x * amount, self.y * amount);
        }

        pub fn length(self: Self) T {
            return math.sqrt(math.pow(T, self.x, 2) + math.pow(T, self.y, 2));
        }

        /// Normalizes this Vector.
        /// That is, returns a Vector with the same direction but with length 1.
        pub fn normalized(self: Self) Self {
            const len = self.length();
            return new(self.x / len, self.y / len);
        }

        /// Move current Vector towards another by an absolute value.
        pub fn moveToward(self: *Self, other: Self, amount: T) void {
            const direction = other.subtract(self.*).normalized();
            self.* = self.add(direction.rescale(amount));
        }

        /// Move current Vector towards another by the percentage of the distance.
        pub fn redistance(self: *Self, other: Self, percent: T) void {
            const direction = other.subtract(self.*);
            self.* = self.add(direction.rescale(percent));
        }

        pub fn equals(self: Self, other: Self) bool {
            return self.x == other.x and self.y == other.y;
        }

        pub fn lossyCast(self: Self, comptime N: type) Vector(N) {
            return Vector(N).new(std.math.lossyCast(N, self.x), std.math.lossyCast(N, self.y));
        }
    };
}
