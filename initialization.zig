const expect = @import("std").testing.expect;

test "initialization" {
    // weird but ok. undefined and null both existing! I hate it.
    var x: i32 = undefined;
    x = 1;
    expect(x == 1);
}
