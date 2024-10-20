const std = @import("std");
const testing = std.testing;

const cs = @import("caesar.zig");

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

test "key goes back to zero (cipher)" {
    var allocator = testing.allocator;

    const result1 = try cs.cipher("A", 26, &allocator);
    const result2 = try cs.cipher("A", 27, &allocator);
    const result3 = try cs.cipher("Z", 26, &allocator);
    const result4 = try cs.cipher("Z", 27, &allocator);
    defer allocator.free(result1);
    defer allocator.free(result2);
    defer allocator.free(result3);
    defer allocator.free(result4);

    try testing.expectEqualStrings(result1, "A");
    try testing.expectEqualStrings(result2, "B");
    try testing.expectEqualStrings(result3, "Z");
    try testing.expectEqualStrings(result4, "A");
}

test "rotates to end" {
    var allocator = testing.allocator;

    const result = try cs.decipher("a", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "Z");
}

test "key goes back to zero (decipher)" {
    var allocator = testing.allocator;

    const result1 = try cs.decipher("A", 26, &allocator);
    const result2 = try cs.decipher("A", 27, &allocator);
    const result3 = try cs.decipher("Z", 26, &allocator);
    const result4 = try cs.decipher("Z", 27, &allocator);
    defer allocator.free(result1);
    defer allocator.free(result2);
    defer allocator.free(result3);
    defer allocator.free(result4);

    try testing.expectEqualStrings(result1, "A");
    try testing.expectEqualStrings(result2, "Z");
    try testing.expectEqualStrings(result3, "Z");
    try testing.expectEqualStrings(result4, "Y");
}
