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
        .value = undefined, // this is gonna be junk
    };
    try stdout.print("var box with undefined: {}\n", vbox);

    var vbox2 = Box(Point){
        .value = Point{}, // this is the default value
    };
    try stdout.print("var box with explicit defaults: {}\n", vbox2);

    // looks like the value of this winds up in bss.
    // https://en.wikipedia.org/wiki/.bss
    const cbox = Box(Point){
        .value = undefined, // this is zeroed out memory
    };
    try stdout.print("const box with undefined: {}\n", cbox);

    try stdout.print("Box literal with undefined: {}\n", Box(Point){
        .value = undefined, // this is also zeroed out memory
    });
}
