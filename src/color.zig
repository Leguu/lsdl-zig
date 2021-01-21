/// A Color struct with a few default values.
/// May move the default color values to an enum later.
pub const Color = struct {
    red: u8,
    green: u8,
    blue: u8,
    alpha: u8,

    const Self = @This();

    pub fn new(red: u8, green: u8, blue: u8, alpha: u8) Self {
        return Self{ .red = red, .green = green, .blue = blue, .alpha = alpha };
    }

    pub fn black() Self {
        return new(0, 0, 0, 255);
    }

    /// Give level as a number out of 255.
    pub fn gray(level: u8) Self {
        return new(level, level, level, 255);
    }

    pub fn white() Self {
        return new(255, 255, 255, 255);
    }
};
