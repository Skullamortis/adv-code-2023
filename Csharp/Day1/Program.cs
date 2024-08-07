using System.Text.RegularExpressions;

internal class Program
{
    private static void Main(string[] args)
    {
        static void main()
        {
            List<int> mylist = new List<int>();
            var s1 = File.ReadLines("input.txt");
            foreach (var line in s1)
            {
                string numbersOnly = Regex.Replace(line, "[^0-9]", "");
                char a = numbersOnly[0];
                char b = numbersOnly[numbersOnly.Length - 1];
                int new_number = int.Parse(a.ToString() + b.ToString());
                mylist.Add(new_number);
            }
            Console.WriteLine(mylist.Sum());
        }
        main();
    }
}
