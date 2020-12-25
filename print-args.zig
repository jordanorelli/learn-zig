//! print-args prints all supplied args and then exits
const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const alloc = &arena.allocator;

    var args = std.process.args();
    _ = args.next(alloc); // skip first arg
    while (args.next(alloc)) |arg| {
        try stdout.print("{}\n", .{arg});
    }
}
