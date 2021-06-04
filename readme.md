# SDL2 Library for Zig

Convenience Zig wrapper for SDL2. This library provides a few additional features over just using SDL2. First off, takes advantage of Zig's OOP features to make code smaller. There's also other features relating to Colors, Inputting, and Timers (FPS regulation) that may be helpful in developing software. See my [verlet-zig](https://github.com/Leguu/verlet-zig) program as an example of this library in action. 

I am currently planning to make this library more game-friendly. Functionality relating to images and audio is planned. If you wish to use SDL features that are not included in lsdl, you can access the C functions directly in `lsdl.zig`, for example, `lsdl.SDL_JoystickGetBall(...)`.

Since this is for convenience, do not expect performance - for that, you can import SDL2 directly. Some of the library is documented, however, it's fairly simple, so you should be able to understand it even without comments.

## Use

I suggest using Git's submodules feature to import this library into your program. Don't forget to add the library in your `build.zig`:

```zig
pub fn build(b: *Builder) void {
    // ...
    const exe = b.addExecutable("project", "src/main.zig");
    exe.addPackagePath("lsdl", "lib/lsdl-zig/src/lsdl.zig");
    // ...
}
```

## Todo

- [x] Spritesheet and animation classes
- [x] Fix `timer.zig` (use accumulators and wait to minimize CPU use)
- [x] Add font-chaching for increasing performance
    - [ ] Improve font-caching for different Text objects
- [ ] Event system
- [ ] Implement interfaces
- [ ] Implement physics engine
- [ ] Particle engine?
- [ ] Bounding box image utility
- [ ] Refactor input and constants to use enums
- [ ] Re-write entire library to use structs closer to SDL
