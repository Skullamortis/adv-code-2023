import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class StringIntPair {
  String str;
  int num;

  public StringIntPair(String str, int num) {
    this.str = str;
    this.num = num;
  }
}

public class day2 {

  public static void sortStringListByIntList(List<List<String>> stringList, List<List<Integer>> intList) {
    for (int i = 0; i < stringList.size(); i++) {
      List<StringIntPair> combinedList = new ArrayList<>();

      for (int j = 0; j < stringList.get(i).size(); j++) {
        String str = stringList.get(i).get(j);
        int num = intList.get(i).get(j);
        combinedList.add(new StringIntPair(str, num));
      }

      Collections.sort(combinedList, Comparator.comparingInt(pair -> pair.num));

      List<String> sortedStringList = new ArrayList<>();
      for (StringIntPair pair : combinedList) {
        sortedStringList.add(pair.str);
      }

      stringList.set(i, sortedStringList);
    }
  }

  public static void main(String[] args) {

    Hashtable<String, String> pair_numbers = new Hashtable<String, String>();
    pair_numbers.put("one", "1");
    pair_numbers.put("two", "2");
    pair_numbers.put("three", "3");
    pair_numbers.put("four", "4");
    pair_numbers.put("five", "5");
    pair_numbers.put("six", "6");
    pair_numbers.put("seven", "7");
    pair_numbers.put("eight", "8");
    pair_numbers.put("nine", "9");

    List<String> file = new ArrayList<>();
    try {
      file = Files.readAllLines(Paths.get("input.txt"));
    } catch (IOException e) {
      e.printStackTrace();
    }

    List<List<String>> mylist2 = new ArrayList<List<String>>();
    List<List<Integer>> mylist2_index = new ArrayList<List<Integer>>();
    for (String element : file) {
      List<String> mylist = new ArrayList<String>();
      List<Integer> mylist_index = new ArrayList<Integer>();
      Integer count = 0;
      for (String str : pair_numbers.keySet()) {
        Pattern pattern = Pattern.compile(str, Pattern.CASE_INSENSITIVE);
        Matcher match = pattern.matcher(element);
        while (match.find()) {

          // System.out.println(match.group());
          String parsed_number = element.replace(str, pair_numbers.get(str));
          mylist.add(parsed_number);
          mylist_index.add(match.start());
          ++count;
        }
      }
      if (count <= 0) {
        mylist.add(element);
        mylist_index.add(0);
      }
      mylist2.add(mylist);
      mylist2_index.add(mylist_index);
    }

    sortStringListByIntList(mylist2, mylist2_index);

    List<Integer> final_numbers = new ArrayList<>();
    for (List<String> res : mylist2) {
      String parsed_number = String.join("", res);
      String strip = parsed_number.replaceAll("[^\\d]", "");
      String f_number = strip.substring(0, 1);
      String l_number = strip.substring(strip.length() - 1);
      final_numbers.add(Integer.valueOf(f_number.concat(l_number)));
    }

    int final_sum = 0;
    for (Integer i : final_numbers) {
      final_sum += i;
    }
    System.out.println(final_sum);
  }

}
