import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class day1 {
  public static void main(String[] args) {
    List<String> file = new ArrayList<>();
    try {
      file = Files.readAllLines(Paths.get("input.txt"));
    } catch (IOException e) {
      e.printStackTrace();
    }

    ArrayList<Integer> full_list = new ArrayList<>();
    for (String element : file) {
      String parsed_number = element.replaceAll("[^\\d]", "");
      String first_number = parsed_number.substring(0, 1);
      String last_number = parsed_number.substring(parsed_number.length() - 1);
      full_list.add(Integer.valueOf(first_number.concat(last_number)));
    }
    int final_sum = 0;
    for (Integer i : full_list) {
      final_sum += i;
    }
    // System.out.println(full_list);
    System.out.println(final_sum);
  }

  @Override
  public String toString() {
    return "day1 []";
  }

}
