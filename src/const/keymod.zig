// Enumeration of valid key mods (possibly OR'd together).
pub const NONE = 0x0000;
pub const LSHIFT = 0x0001;
pub const RSHIFT = 0x0002;
pub const LCTRL = 0x0040;
pub const RCTRL = 0x0080;
pub const LALT = 0x0100;
pub const RALT = 0x0200;
pub const LGUI = 0x0400;
pub const RGUI = 0x0800;
pub const NUM = 0x1000;
pub const CAPS = 0x2000;
pub const MODE = 0x4000;
pub const RESERVED = 0x8000;

pub const CTRL = @enumToInt(LCTRL) | @enumToInt(RCTRL);
pub const SHIFT = @enumToInt(LSHIFT) | @enumToInt(LSHIFT);
pub const ALT = @enumToInt(LALT) | @enumToInt(RALT);
pub const GUI = @enumToInt(LGUI) | @enumToInt(RGUI);
