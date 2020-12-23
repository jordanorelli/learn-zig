const std = @import("std");
const os = std.os;
const print = std.debug.print;

pub fn main() !void {
    var buf: [256]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var allocator = &fba.allocator;

    const cwd = try allocator.alloc(u8, 256);
    defer allocator.free(cwd);

    const z = try os.getcwd(cwd);
    print("{}\n", .{z});
}
