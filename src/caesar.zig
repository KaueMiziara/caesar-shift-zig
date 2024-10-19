const std = @import("std");
const testing = std.testing;

pub fn cipher(text: []const u8, shift: u8, allocator: *std.mem.Allocator) ![]u8 {
    var result = try allocator.alloc(u8, text.len);

    for (text, 0..) |char, i| {
        const upper_char = std.ascii.toUpper(char);

        if (upper_char != ' ') {
            result[i] = 65 + ((upper_char + shift - 65) % 26);
        } else {
            result[i] = upper_char;
        }
    }

    return result;
}

pub fn decipher(text: []const u8, shift: u8, allocator: *std.mem.Allocator) ![]u8 {
    var result = try allocator.alloc(u8, text.len);

    for (text, 0..) |char, i| {
        const upper_char = std.ascii.toUpper(char);

        if (upper_char != ' ') {
            result[i] = 65 + ((upper_char - shift + 65) % 26);
        } else {
            result[i] = upper_char;
        }
    }

    return result;
}

test "test cipher" {
    var allocator = testing.allocator;

    const text = "ABC";

    const result = try cipher(text, 2, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "CDE");
}

test "test decipher" {
    var allocator = testing.allocator;

    const text = "CDE";

    const result = try decipher(text, 2, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "ABC");
}

test "lower case to upper" {
    var allocator = testing.allocator;

    const result = try cipher("abc", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "BCD");
}

test "string with spaces works" {
    var allocator = testing.allocator;

    const result = try cipher("attack the castle", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "BUUBDL UIF DBTUMF");
}

test "rotates back to start" {
    var allocator = testing.allocator;

    const result = try cipher("z", 1, &allocator);
    defer allocator.free(result);

    try testing.expectEqualStrings(result, "A");
}
