const std = @import("std");
const print = std.debug.print;

const x: i32 = 1234;

pub fn main() void {
    print("x: {}\n", .{x});
    // confirmed, this program can't be built, so this guarantee is checked at
    // compile-time, which is what I expected.
    x += 1;
    print("x: {}\n", .{x});
}
