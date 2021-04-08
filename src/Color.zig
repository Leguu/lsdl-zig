//! A Color struct with a few default values.
//! May move the default color values to an enum later.

red: u8,
green: u8,
blue: u8,
alpha: u8,

const Self = @This();

pub fn new(red: u8, green: u8, blue: u8, alpha: u8) Self {
    return Self{ .red = red, .green = green, .blue = blue, .alpha = alpha };
}

pub const black = new(0, 0, 0, 225);
pub const white = new(255, 255, 255, 255);

pub const light_gray = new(190, 190, 190, 255);
pub const gray = new(127, 127, 127, 255);
pub const dark_gray = new(64, 64, 64, 255);

/// Give level as a number out of 255.
pub fn uniform(level: u8) Self {
    return new(level, level, level, 255);
}
