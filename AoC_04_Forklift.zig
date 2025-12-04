const std = @import("std");

pub fn main() !void {
    try part_one();
    try part_two();
}

pub fn part_one() !void {
    const grid, const N = try read_grid("input.txt");
    const accessible: i32 = check_accessible(grid, N, false);
    std.debug.print("{d}\n", .{accessible});
}

pub fn part_two() !void {
    const grid, const N = try read_grid("input.txt");
    var accessible: i32 = 0;
    var tmp: i32 = check_accessible(grid, N, true);
    while (tmp != 0) {
        accessible += tmp;
        tmp = check_accessible(grid, N, true);
    }
    std.debug.print("{d}\n", .{accessible});
}

fn read_grid(file_name: []const u8) !struct { [][200]u8, usize } {
    const file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    var buffer: [1000]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var grid: [200][200]u8 = undefined;

    var y: usize = 0;
    var N: usize = 0;
    while (file_reader.interface.takeDelimiterExclusive('\n')) |line| : (y += 1) {
        N = line.len;
        for (line, 0..) |c, x| {
            grid[x][y] = c;
        }
        if (!file_reader.atEnd())
            file_reader.interface.toss(1);
    } else |_| {}

    return .{ &grid, N };
}

fn check_accessible(grid: [][200]u8, N: usize, remove: bool) i32 {
    var accessible: i32 = 0;
    var y: usize = 0;
    var x: usize = 0;
    while (y < N) : (y += 1) {
        x = 0;
        while (x < N) : (x += 1) {
            if (grid[x][y] != '@')
                continue;

            var occupied: i32 = 0;
            var py = if (y > 0) (y - 1) else y;
            while (py <= y + 1 and py < N) : (py += 1) {
                var px = if (x > 0) (x - 1) else x;
                while (px <= x + 1 and px < N) : (px += 1) {
                    if (px == x and py == y)
                        continue;
                    if (grid[px][py] == '@')
                        occupied += 1;
                }
            }
            if (occupied < 4) {
                accessible += 1;
                if (remove) grid[x][y] = '.';
            }
        }
    }
    return accessible;
}
