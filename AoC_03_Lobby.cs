var data = File.ReadAllLines(@"input.txt");
PartOne();
PartTwo();

void PartOne()
{
    long result = 0;
    foreach (var line in data)
    {
        result += MaxRating(line, 2);
    }
    Console.WriteLine(result);
}

void PartTwo()
{
    long result = 0;
    foreach (var line in data)
    {
        result += MaxRating(line, 12);
    }
    Console.WriteLine(result);
}

long MaxRating(string line, int bank)
{
    int i = 0, k, max = 0;
    char[] rating = new char[bank];

    for (k = 0; k < bank; ++k)
    {
        for (i = max; i < line.Length - bank + k + 1; ++i)
        {
            if (line[i] > line[max])
            {
                max = i;
            }
        }
        rating[k] = line[max];
        max++;
    }

    return long.Parse(new string(rating));
}