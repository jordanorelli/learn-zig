const std = @import("std");

pub fn main() void {
    // if you remove this line, the program does not compile because it detects
    // the overflow at compile time. A little confusing that it's not
    // @setCompileTimeSafety but that's ok.
    @setRuntimeSafety(false);

    var x: u8 = 255;
    x += 1; // <-- this is an overflow

    // this prints 0 on my machine but is apparently undefined. I wonder what
    // it prints on other machines?
    std.debug.print("X: {}\n", .{x});
}
