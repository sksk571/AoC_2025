var data = File.ReadAllText(@"input.txt").Split(",");
PartOne();
PartTwo();

void PartOne()
{
    long invalid = 0;
    foreach (var range in data)
    {
        string[] parts = range.Split('-');

        long begin = long.Parse(parts[0]), end = long.Parse(parts[1]);
        for (long i = begin; i <= end; ++i)
        {
            string digits = i.ToString();
            if (digits.Length % 2 != 0)
                continue;

            int j, halfLen = digits.Length / 2;
            for (j = 0; j < halfLen; ++j)
            {
                if (digits[j] != digits[j + halfLen])
                {
                    break;
                }
            }
            if (j == halfLen)
            {
                invalid += i;
            }
        }
    }

    Console.WriteLine(invalid);
}

void PartTwo()
{
    long invalid = 0;
    foreach (var range in data)
    {
        string[] parts = range.Split('-');

        long begin = long.Parse(parts[0]), end = long.Parse(parts[1]);
        for (long i = begin; i <= end; ++i)
        {
            string digits = i.ToString();
            for (int step = 1; step <= digits.Length / 2; ++step)
            {
                if (digits.Length % step != 0)
                    continue;
                bool isInvalid = true;
                for (int j = 0; j < step; ++j)
                {
                    char d = digits[j];
                    for (int k = j + step; k < digits.Length; k += step)
                        if (digits[k] != d)
                            isInvalid = false;
                }
                if (isInvalid)
                {
                    invalid += i;
                    break;
                }
            }
        }
    }

    Console.WriteLine(invalid);
}
