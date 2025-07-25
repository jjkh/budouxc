# budouxc

[`budouxc`](https://github.com/memononen/budouxc) packaged for the [Zig](https://ziglang.org/) build system.

## Status

Mostly untested:

* Example runs on `aarch64-macos`/`x86_64-macos`
* Compatible with Zig `0.14.0` and `0.15.0-dev.1184+c41ac8f19`

## Usage

```zig
const budouxc_dep = b.dependency("budouxc", .{
    .target = target,
    .optimize = optimize,
});
exe.linkLibrary(budouxc_dep.artifact("budouxc"));
```

## Example

```sh
zig build example     # builds the example
zig build run-example # builds and runs the example
```

## Dependencies

`budouxc` only depends on libc.
