const std = @import("std");

pub fn main() !void {
    try part_one();
    try part_two();
}

pub fn part_one() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [100]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var invalid: i64 = 0;

    while (file_reader.interface.takeDelimiterExclusive(',')) |range| {
        const separator = std.mem.indexOf(u8, range, "-") orelse 0;
        const begin: i64 = try std.fmt.parseInt(i64, range[0..separator], 10);
        const end: i64 = try std.fmt.parseInt(i64, range[separator + 1 ..], 10);

        var i: i64 = begin;
        const max_len = 20;
        var buf: [max_len]u8 = undefined;
        while (i <= end) : (i += 1) {
            const digits = try std.fmt.bufPrint(&buf, "{}", .{i});
            if (@mod(digits.len, 2) != 0)
                continue;
            var j: usize = 0;
            const half: usize = digits.len / 2;
            while (j < half) : (j += 1) {
                if (digits[j] != digits[j + half])
                    break;
            }
            if (j == half) {
                invalid += i;
            }
        }
        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{invalid});
}

pub fn part_two() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [100]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var invalid: i64 = 0;

    while (file_reader.interface.takeDelimiterExclusive(',')) |range| {
        const separator = std.mem.indexOf(u8, range, "-") orelse 0;
        const begin: i64 = try std.fmt.parseInt(i64, range[0..separator], 10);
        const end: i64 = try std.fmt.parseInt(i64, range[separator + 1 ..], 10);

        var i: i64 = begin;
        const max_len = 20;
        var buf: [max_len]u8 = undefined;
        while (i <= end) : (i += 1) {
            const digits = try std.fmt.bufPrint(&buf, "{}", .{i});
            const half: usize = digits.len / 2;

            var step: usize = 1;
            while (step <= half) : (step += 1) {
                if (@mod(digits.len, step) != 0)
                    continue;
                var is_invalid: bool = true;
                var j: usize = 0;
                while (j < step) : (j += 1) {
                    const d: u8 = digits[j];
                    var k: usize = j + step;

                    while (k < digits.len) : (k += step) {
                        if (digits[k] != d)
                            is_invalid = false;
                    }
                }
                if (is_invalid) {
                    invalid += i;
                    break;
                }
            }
        }
        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{invalid});
}
