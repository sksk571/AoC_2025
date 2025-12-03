const std = @import("std");

pub fn main() !void {
    try part_one();
    try part_two();
}

pub fn part_one() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [1000]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var rating: i64 = 0;

    while (file_reader.interface.takeDelimiterExclusive('\n')) |line| {
        rating += max_rating(line, 2);
        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{rating});
}

pub fn part_two() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [1000]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var rating: i64 = 0;

    while (file_reader.interface.takeDelimiterExclusive('\n')) |line| {
        rating += max_rating(line, 12);
        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{rating});
}

fn max_rating(line: []u8, bank: comptime_int) i64 {
    var i: usize = 0;
    var k: usize = 0;
    var max: usize = 0;
    var rating: [bank]u8 = undefined;
    while (k < bank) : (k += 1) {
        i = max;
        while (i < line.len - bank + k + 1) : (i += 1) {
            if (line[i] > line[max]) {
                max = i;
            }
        }
        rating[k] = line[max];
        max += 1;
    }
    return std.fmt.parseInt(i64, rating[0..bank], 10) catch 0;
}
