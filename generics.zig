const std = @import("std");

fn List(comptime T: type) type {
    return struct {
        items: []T,
        len: usize,
    };
}

pub fn main() void {
    var buffer: [10]i32 = undefined;

    var list = List(i32){
        .items = &buffer,
        .len = 0,
    };

    // the same thing with an intermediate const to make it a little bit more
    // clear:
    // const IntList = List(i32);
    // var list = IntList{
    //     .items = &buffer,
    //     .len = 0,
    // };

    std.debug.print("{}\n", .{list.items.len});
}
