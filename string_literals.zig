const expect = @import("std").testing.expect;
const mem = @import("std").mem;

test "string literals" {
    const bytes = "hello";
    expect(@TypeOf(bytes) == *const [5:0]u8);
    expect(bytes.len == 5);
    expect(bytes[1] == 'e');
    expect(bytes[5] == 0);
    expect('e' == '\x65');
    expect('\u{1f4a9}' == 128169);
    expect('💯' == 128175);
    expect(mem.eql(u8, "hello", "h\x65llo"));
}
