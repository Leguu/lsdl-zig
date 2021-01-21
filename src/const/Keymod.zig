// Enumeration of valid key mods (possibly OR'd together).
pub const Keymod = enum(i32) {
    const Self = @This();

    NONE = 0x0000,
    LSHIFT = 0x0001,
    RSHIFT = 0x0002,
    LCTRL = 0x0040,
    RCTRL = 0x0080,
    LALT = 0x0100,
    RALT = 0x0200,
    LGUI = 0x0400,
    RGUI = 0x0800,
    NUM = 0x1000,
    CAPS = 0x2000,
    MODE = 0x4000,
    RESERVED = 0x8000,

    pub const CTRL = @enumToInt(Self.LCTRL) | @enumToInt(Self.RCTRL);
    pub const SHIFT = @enumToInt(Self.LSHIFT) | @enumToInt(Self.LSHIFT);
    pub const ALT = @enumToInt(Self.LALT) | @enumToInt(Self.RALT);
    pub const GUI = @enumToInt(Self.LGUI) | @enumToInt(Self.RGUI);
};
