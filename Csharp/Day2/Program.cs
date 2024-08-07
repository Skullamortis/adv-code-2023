using System.Text.RegularExpressions;

internal class Program
{
    private static void Main(string[] args)
    {
        static void main()
        {
            IEnumerable<string> s1 = File.ReadLines("input.txt");

            List<List<string>> mylist2 = new();
            List<List<int>> indexes2 = new();
            List<int> integers_sorted = new();
            List<string> numbers_str =
                new() { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

            List<string> numbers = new() { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
            var words_and_numbers = numbers_str.Zip(
                numbers,
                (w, n) => new { Word = w, Number = n }
            );

            static void SortStringListByIntList(
                List<List<string>> stringList,
                List<List<int>> intList
            )
            {
                for (int i = 0; i < stringList.Count; i++)
                {
                    List<Tuple<string, int>> combinedList = stringList[i]
                        .Zip(intList[i], (s, num) => new Tuple<string, int>(s, num))
                        .ToList();

                    combinedList.Sort((a, b) => a.Item2.CompareTo(b.Item2));

                    stringList[i] = combinedList.Select(tuple => tuple.Item1).ToList();
                }
            }

            foreach (string line in s1)
            {
                List<string> mylist = new();
                List<int> indexes = new();
                int count = 0;
                foreach (var element in words_and_numbers)
                {
                    Match regex = Regex.Match(line, element.Word);
                    if (regex.Success)
                    {
                        ++count;
                        foreach (Match m in Regex.Matches(line, element.Word).Cast<Match>())
                        {
                            string elements = Regex.Replace(line, element.Word, element.Number);
                            mylist.Add(elements);
                            indexes.Add(m.Index);
                        }
                    }
                }
                if (count <= 0)
                {
                    mylist.Add(line);
                    indexes.Add(0);
                }
                indexes2.Add(indexes);
                mylist2.Add(mylist);
            }
            SortStringListByIntList(mylist2, indexes2);

            foreach (List<string> res in mylist2)
            {
                string elements_replaced = string.Join("", res.ToArray());
                string strip = Regex.Replace(elements_replaced, "[^0-9]", "");
                char a = strip[0];
                char b = strip[strip.Length - 1];

                int new_number = int.Parse(a.ToString() + b.ToString());
                integers_sorted.Add(new_number);
            }
            Console.WriteLine(integers_sorted.Sum());
        }

        main();
    }
}
