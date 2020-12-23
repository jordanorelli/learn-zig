const std = @import("std");
const expect = std.testing.expect;

test "comptime vars" {
    var x: i32 = 1;
    comptime var y: i32 = 1;

    x += 1;
    y += 1;

    expect(x == 2);
    expect(y == 2);

    if (y != 2) {
        // this compile error never triggers. y is a comptime variable, which
        // makes `y != 2` knowable at comptime (would we call this a comptime
        // expression?). the "if" statement is statically evaluated. I don't
        // get it.
        @compileError("wrong y value");
    }
}
