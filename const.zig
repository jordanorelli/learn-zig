const x = 1234;

fn foo() void {
    // can const inside function scope
    const y = 5678;

    // this is prevented presumably at compile time
    y += 1;
}

test "assignment" {
    foo();
}
