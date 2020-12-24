const std = @import("std");
const stdout = std.io.getStdOut().writer();

fn Box(comptime T: type) type {
    return struct {
        value: T,
    };
}

const Point = struct {
    X: i32 = 1,
    Y: i32 = 2,
};

pub fn main() !void {
    var vbox = Box(Point){
        .value = undefined,
    };
    try stdout.print("var box with undefined: {}\n", vbox);

    var vbox2 = Box(Point){
        .value = Point{},
    };
    try stdout.print("var box with explicit defaults: {}\n", vbox2);

    const cbox = Box(Point){
        .value = undefined,
    };
    try stdout.print("const box with undefined: {}\n", cbox);

    try stdout.print("Box literal with undefined: {}\n", Box(Point){
        .value = undefined,
    });
}
