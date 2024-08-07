#!/usr/bin/python3
import re

string_list = []
final_list = []
with open("input1.txt", encoding="utf-8") as file:
    read_data = file.readlines()

for line in read_data:
    string_list.append(re.sub("[^0-9]", "", line))

for number in string_list:
    first_number = number[0]
    last_number = number[len(number) - 1]
    final_list.append(int(first_number + last_number))

print(sum(final_list))
