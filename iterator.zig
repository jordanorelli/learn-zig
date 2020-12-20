const std = @import("std");

pub fn main() void {
    const msg = "hello this is dog";
    var words = std.mem.tokenize(msg, " ");
    while (words.next()) |word| {
        std.debug.print("{}\n", .{word});
    }
}
