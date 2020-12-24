const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    const name = switch (builtin.os.tag) {
        .windows => "windows",
        .linux => "linux",
        else => "mystery",
    };
    std.debug.print("hello {}\n", .{name});
}
