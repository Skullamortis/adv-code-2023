import re

with open("inputMain.txt", encoding="utf-8") as file:
    schematics = [
        [char for char in line.strip("\n")] for line in file if line.strip() != ""
    ]
x_length = len(schematics)
y_length = len(schematics[0])
# print(schematics[13][13])
numbers = []
not_numbers = []
for i in range(y_length):
    marker = False
    is_number = []
    for j in range(x_length):
        if schematics[i][j].isnumeric():
            is_number.append(schematics[i][j])
            if i == 0:
                if j == 0:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j + 1])
                    ):
                        marker = True
                elif j == (x_length - 1):
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j - 1])
                    ):
                        marker = True
                else:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j + 1])
                    ):
                        marker = True
            elif i == (y_length - 1):
                if j == 0:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j + 1])
                    ):
                        marker = True
                elif j == (x_length - 1):
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j - 1])
                    ):
                        marker = True
                else:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j + 1])
                    ):
                        marker = True
            else:
                if j == 0:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j + 1])
                    ):
                        marker = True
                elif j == (x_length - 1):
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j - 1])
                    ):
                        marker = True
                else:
                    if (
                        re.findall("[^0123456789. ]", schematics[i][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i - 1][j + 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j - 1])
                        or re.findall("[^0123456789. ]", schematics[i + 1][j + 1])
                    ):
                        marker = True

        if not (schematics[i][j].isnumeric()):
            if marker:
                # print("Found number:" + "".join(is_number))
                numbers.append(int("".join(is_number)))
            elif is_number:
                not_numbers.append(int("".join(is_number)))
                # print("Not a number:" + "".join(is_number))
            marker = False
            is_number.clear()
    if marker:
        # print("Found number:" + "".join(is_number))
        numbers.append(int("".join(is_number)))
print(sum(numbers))
