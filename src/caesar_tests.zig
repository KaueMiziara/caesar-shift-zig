const std = @import("std");
const testing = std.testing;

const cs = @import("caesar");

test "test cipher" {
    var allocator = testing.allocator;

    const text = "ABC";

    const result = try cs.cipher(text, 2, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "CDE");
}

test "test decipher" {
    var allocator = testing.allocator;

    const text = "CDE";

    const result = try cs.decipher(text, 2, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "ABC");
}

test "lower case to upper" {
    var allocator = testing.allocator;

    const result = try cs.cipher("abc", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "BCD");
}

test "string with spaces works" {
    var allocator = testing.allocator;

    const result = try cs.cipher("attack the castle", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "BUUBDL UIF DBTUMF");
}

test "rotates back to start" {
    var allocator = testing.allocator;

    const result = try cs.cipher("z", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "A");
}
