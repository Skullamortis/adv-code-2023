import re

max_game_stones = {"red": 12, "green": 13, "blue": 14}
games_list = []
valid_games_sum = 0
with open("input_part2.txt", encoding="utf-8") as file:
    read_data = file.readlines()

for line in read_data:
    line_get_values = re.split(":", line)
    redgames_numbers = []
    greengames_numbers = []
    bluegames_numbers = []

    games_played = re.split(";", line_get_values[1])
    current_game = re.findall(r"\d+", line_get_values[0])
    for m in games_played:
        red_games = re.findall(r"\d+ red", m)
        green_games = re.findall(r"\d+ green", m)
        blue_games = re.findall(r"\d+ blue", m)
        for i in red_games:
            redgames_numbers.append(i.strip(" red").strip("\n"))
        for j in green_games:
            greengames_numbers.append(j.strip(" green").strip("\n"))
        for k in blue_games:
            bluegames_numbers.append(k.strip(" blue").strip("\n"))
            # print(game_number)

    games_list.append(
        {
            "Game": current_game[0],
            "red": redgames_numbers,
            "green": greengames_numbers,
            "blue": bluegames_numbers,
        }
    )
# print(games_list)
for game in games_list:
    red_valid = True
    green_valid = True
    blue_valid = True
    for reds in game["red"]:
        if int(reds) > int(max_game_stones["red"]):
            red_valid = False
    for greens in game["green"]:
        if int(greens) > int(max_game_stones["green"]):
            green_valid = False
    for blues in game["blue"]:
        if int(blues) > int(max_game_stones["blue"]):
            blue_valid = False
    if red_valid and (green_valid and blue_valid):
        valid_games_sum = valid_games_sum + int(game["Game"])

print("Sum of valid games IDs:", valid_games_sum)
