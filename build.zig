const std = @import("std");
const rl = @import("raylib-zig/build.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    var raylib = rl.getModule(b, "raylib-zig");
    var raylib_math = rl.math.getModule(b, "raylib-zig");

    const exe = b.addExecutable(.{ .name = "lsr", .root_source_file = .{ .path = "src/main.zig" }, .optimize = optimize, .target = target });

    rl.link(b, exe, target, optimize);
    exe.addModule("raylib", raylib);
    exe.addModule("raylib-math", raylib_math);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "run");
    run_step.dependOn(&run_cmd.step);

    b.installArtifact(exe);
}
