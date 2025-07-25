const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("budouxc", .{});
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const src_dir = upstream.path("src");
    const include_dir = upstream.path("include");
    const example_dir = upstream.path("example");

    const lib = b.addLibrary(.{
        .name = "budouxc",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });
    lib.addCSourceFile(.{ .file = src_dir.path(b, "budoux.c") });
    lib.addIncludePath(include_dir);
    lib.installHeader(include_dir.path(b, "budoux.h"), "budoux.h");
    b.installArtifact(lib);

    const examples_step = b.step("example", "Build example executable");
    const example_exe = b.addExecutable(.{
        .name = "boudouxc_example",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    example_exe.linkLibrary(lib);
    example_exe.addCSourceFile(.{ .file = example_dir.path(b, "example.c") });

    const run_example_step = b.step("run-example", "Run example executable");
    const run_example = b.addRunArtifact(example_exe);
    run_example_step.dependOn(&run_example.step);

    const install_example = b.addInstallFileWithDir(example_exe.getEmittedBin(), .bin, example_exe.name);
    examples_step.dependOn(&install_example.step);
}
