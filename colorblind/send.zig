const std = @import("std");
const net = std.net;

const stdout = std.io.getStdOut().writer();
pub const io_mode = .evented;

pub fn main() !void {
    const addr = try net.Address.parseIp("127.0.0.1", 7000);
    try stdout.print("about to send message\n", .{});

    var sendFrame = async send_message(addr);
    //  you can do some other stuff while waiting for send_message to resolve
    try stdout.print("message sent, can do other stuff now\n", .{});
    try stdout.print("alright let's wait\n", .{});

    // now we await the result from that prior async operation
    try await sendFrame;
    try stdout.print("we finished with sendFrame\n", .{});
}

fn send_message(addr: net.Address) !void {
    var socket = try net.tcpConnectToAddress(addr);
    defer socket.close();

    _ = try socket.write("Hello World!\n");
}
