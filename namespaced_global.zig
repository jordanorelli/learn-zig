const std = @import("std");
const expect = std.testing.expect;

test "namespaced global variable" {
    expect(foo() == 1235);
    expect(foo() == 1236);
}

fn foo() i32 {
    const S = struct {
        var x: i32 = 1234;
    };
    S.x += 1;
    return S.x;
}
