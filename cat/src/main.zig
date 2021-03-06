const std = @import("std");
const page_allocator = std.heap.page_allocator;
const format = std.fmt.format;
const Allocator = std.mem.Allocator;
const File = std.fs.File;
const ArrayList = std.ArrayList;
const stdout = std.io.getStdOut();

pub fn main() !void {
    var mem_root = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = mem_root.deinit();

    try run(&mem_root.allocator);
}

fn run(mem: *Allocator) !void {
    const stdin = std.io.getStdIn();
    const stderr = std.io.getStdErr();

    var handles = ArrayList(File).init(mem);
    defer {
        for (handles.items) |f| {
            f.close();
        }
        handles.deinit();
    }

    var args = std.process.args();
    defer args.deinit();

    _ = args.skip();
    while (args.next(mem)) |maybe| {
        const arg = try maybe;
        defer mem.free(arg);

        if (std.mem.eql(u8, arg, "-")) {
            try handles.append(stdin);
        } else {
            const f = openFile(arg) catch |err| {
                stderr.writer().print("Error with {}: {}\n", .{ arg, err }) catch {};
                std.os.exit(1);
            };
            try handles.append(f);
        }
    }

    const page = try page_allocator.alloc(u8, std.mem.page_size);
    defer page_allocator.free(page);

    if (handles.items.len == 0) {
        try dump(page, stdin);
        return;
    }

    for (handles.items) |f| {
        try dump(page, f);
    }
}

// dump dumps a file to stdout, utilizing the provided page of memory as a
// transfer buffer.
fn dump(page: []u8, f: File) !void {
    while (true) {
        var n = try f.read(page);
        if (n <= 0) {
            return;
        }
        _ = try stdout.write(page[0..n]);
    }
}

const BadFileType = error.BadFileType;

var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
fn openFile(rel: []u8) !File {
    const path = try std.fs.realpath(rel, &path_buffer);
    const f = try std.fs.openFileAbsolute(path, .{ .read = true });
    const fi = try f.stat();
    if (fi.kind != .File) {
        return BadFileType;
    }
    return f;
}
