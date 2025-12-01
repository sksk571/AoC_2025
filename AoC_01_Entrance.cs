var data = File.ReadAllLines(@"c:\tmp\input.txt");

int dial = 50;
int zero = 0;

foreach (var line in data)
{
    int rotation = int.Parse(line[1..]);
    // --- PART 1
    // dial = (dial +
    //     (line[0] == 'L' ? (100 - rotation) : rotation)) % 100;

    // if (dial == 0)
    //     zero++;

    // --- PART 2
    while (rotation != 0)
    {
        if (line[0] == 'L')
            dial--;
        else
            dial++;
        dial = dial % 100;
        if (dial == 0)
            zero++;
        rotation--;
    }
}

Console.WriteLine(zero);