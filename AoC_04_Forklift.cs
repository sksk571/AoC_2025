var grid = File.ReadAllLines("input.txt").Select(line => line.ToCharArray()).ToArray();
PartOne();
PartTwo();

void PartOne()
{
    var accessible = CheckAccessible(grid, remove: false);
    Console.WriteLine(accessible);
}

void PartTwo()
{
    var accessible = 0;
    var tmp = CheckAccessible(grid, remove: true);
    while (tmp != 0)
    {
        accessible += tmp;
        tmp = CheckAccessible(grid, remove: true);
    }
    Console.WriteLine(accessible);
}

int CheckAccessible(char[][] grid, bool remove)
{
    int N = grid.Length;
    int accessible = 0;
    for (int y = 0; y < N; ++y)
    {
        for (int x = 0; x < N; ++x)
        {
            if (grid[x][y] != '@')
                continue;
            int occupied = 0;
            for (int dx = -1; dx <= 1; ++dx) for (int dy = -1; dy <= 1; ++dy)
                {
                    if (dx == 0 && dy == 0) continue;
                    var px = x + dx;
                    var py = y + dy;
                    if (px < 0 || px >= N || py < 0 || py >= N)
                        continue;
                    if (grid[px][py] == '@')
                        occupied++;
                }
            if (occupied < 4) 
            {
                accessible++;
                if (remove) grid[x][y] = '.';
            }
        }
    }
    return accessible;
}