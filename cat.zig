const std = @import("std");
const page_allocator = std.heap.page_allocator;
const format = std.fmt.format;

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();
    const stderr = std.io.getStdErr();

    const page = try page_allocator.alloc(u8, std.mem.page_size);
    defer page_allocator.free(page);

    while (true) {
        var n = stdin.read(page) catch |err| {
            try stderr.writer().print("Error: {}\n", .{err});
            break;
        };
        if (n <= 0) {
            break;
        }
        _ = try stdout.write(page[0..n]);
    }
}
