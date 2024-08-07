#!/usr/bin/python3
import re

key_pairs = (
    ("one", "1"),
    ("two", "2"),
    ("three", "3"),
    ("four", "4"),
    ("five", "5"),
    ("six", "6"),
    ("seven", "7"),
    ("eight", "8"),
    ("nine", "9"),
)
string_list = []
final_list = []
with open("input_final.txt", encoding="utf-8") as file:
    read_data = file.readlines()

list_indexes = []
list_new_lines = []
for line in read_data:
    indexes = []
    new_line = []
    count_matches = 0
    for i in range(9):
        k = re.search(key_pairs[i][0], line)
        if k:
            for match in re.finditer(key_pairs[i][0], line):
                indexes.append(match.start())
                new_line.append(
                    re.sub(key_pairs[i][0], key_pairs[i][1], line).strip("\n")
                )
                count_matches += 1
    if count_matches == 0:
        indexes.append(0)
        new_line.append(line.strip("\n"))
    list_indexes.append(indexes)
    list_new_lines.append(new_line)


def sort_string_list_by_int_list(string_list, int_list):
    for i in range(len(string_list)):
        combined_list = list(zip(string_list[i], int_list[i]))
        combined_list.sort(key=lambda x: x[1])

        string_list[i] = [pair[0] for pair in combined_list]


final_new_lines = sort_string_list_by_int_list(list_new_lines, list_indexes)
numbers_list = []
for element in list_new_lines:
    numbers_list.append(re.sub("[^0-9]", "", "".join(element)))
for number in numbers_list:
    first_number = number[0]
    last_number = number[len(number) - 1]
    final_list.append(int(first_number + last_number))

print(sum(final_list))
