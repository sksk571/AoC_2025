const std = @import("std");

pub fn main() !void {
    try part_one();
    try part_two();
}

pub fn part_one() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [100]u8 = undefined;
    var dial: i32 = 50;
    var zero: i32 = 0;
    var file_reader = file.reader(&buffer);
    while (file_reader.interface.takeDelimiterExclusive('\n')) |line| {
        const rotation: i32 = try std.fmt.parseInt(i32, line[1..], 10);

        dial = @mod(dial +
            (if (line[0] == 'L') (100 - rotation) else rotation), 100);
        if (dial == 0) zero = zero + 1;

        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{zero});
}

pub fn part_two() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [100]u8 = undefined;
    var dial: i32 = 50;
    var zero: i32 = 0;
    var file_reader = file.reader(&buffer);
    while (file_reader.interface.takeDelimiterExclusive('\n')) |line| {
        var rotation: i32 = try std.fmt.parseInt(i32, line[1..], 10);

        while (rotation != 0) {
            const increment: i32 = if (line[0] == 'L') (-1) else (1);
            dial = @mod(dial +
                increment, 100);
            if (dial == 0) {
                zero = zero + 1;
            }
            rotation = rotation - 1;
        }

        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}
    std.debug.print("{d}\n", .{zero});
}
