const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    switch (builtin.os.tag) {
        .windows => {
            std.debug.print("hello windows OS: {}\n", .{builtin.os.tag});
        },
        .linux => {
            std.debug.print("hello linux-based OS: {}\n", .{builtin.os.tag});
        },
        else => {
            std.debug.print("hello mystery OS: {}\n", .{builtin.os.tag});
        },
    }
}
