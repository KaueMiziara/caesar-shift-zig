const std = @import("std");

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
