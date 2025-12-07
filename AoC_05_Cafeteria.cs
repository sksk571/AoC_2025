var (ranges, ingredients) = ReadData("input.txt");

PartOne();
PartTwo();

(List<(long begin, long end)> ranges, List<long> ingredients) ReadData(string fileName)
{
    var data = File.ReadAllLines("input.txt");

    var ranges = new List<(long begin, long end)>();
    int i, j;
    for (i = 0; i < data.Length && data[i] != ""; ++i)
    {
        var parts = data[i].Split("-");
        ranges.Add((long.Parse(parts[0]), long.Parse(parts[1])));
    }
    i++;
    var ingredients = new List<long>();
    for (; i < data.Length; ++i)
    {
        ingredients.Add(long.Parse(data[i]));
    }
    return (ranges, ingredients);
}

void PartOne()
{
    int fresh = 0;
    foreach (var id in ingredients)
    {
        if (ranges.Any(r => id >= r.begin && id <= r.end))
            fresh++;
    }

    Console.WriteLine(fresh);
}

void PartTwo()
{
    int i,j;
    ranges = ranges.OrderBy(r => r.begin).ThenBy(r => r.end).ToList();
    for (i = 0, j = 1; j < ranges.Count; 
            ++i, ++j)
    {
        if (ranges[j].begin <= ranges[i].end && ranges[j].end >= ranges[i].end)
        {
            ranges[i] = (ranges[i].begin, ranges[j].end);
            ranges.RemoveAt(j);
            i--;
            j--;
        }
        else if (ranges[j].begin >= ranges[i].begin && ranges[j].end <= ranges[i].end)
        {
            ranges.RemoveAt(j);
            i--;
            j--;
        }
    }

    long unique = 0;
    foreach (var r in ranges)
    {
        unique += r.end - r.begin + 1;
    }
    Console.WriteLine(unique);
}