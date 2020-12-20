const std = @import("std");
const assert = std.debug.assert;

test "null @intToPtr" {
    // the ? means that the pointer can be null. If you remove it, the test
    // fails because you're trying to set a null pointer.
    //
    // the 0 can also be written 0x0 but I don't know if there's any practical
    // difference.
    const ptr = @intToPtr(?*i32, 0);
    assert(ptr == null);
}
