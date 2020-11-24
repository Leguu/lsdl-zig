const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("lsdl-zig", "src/main.zig");
    lib.linkLibC();
    lib.linkSystemLibrary("SDL2");
    lib.setBuildMode(mode);
    lib.install();

    var main_tests = b.addTest("src/test.zig");
    main_tests.linkLibC();
    main_tests.linkSystemLibrary("SDL2");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
