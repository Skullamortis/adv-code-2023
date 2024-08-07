import re

max_game_stones = {"red": 12, "green": 13, "blue": 14}
games_list = []
game_power = []
with open("input_final.txt", encoding="utf-8") as file:
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
            redgames_numbers.append(int(i.strip(" red").strip("\n")))
        for j in green_games:
            greengames_numbers.append(int(j.strip(" green").strip("\n")))
        for k in blue_games:
            bluegames_numbers.append(int(k.strip(" blue").strip("\n")))
            # print(game_number)

    games_list.append(
        {
            "Game": current_game[0],
            "red": redgames_numbers,
            "green": greengames_numbers,
            "blue": bluegames_numbers,
        }
    )
for game in games_list:
    min_red = max(game["red"])
    min_green = max(game["green"])
    min_blue = max(game["blue"])
    game_power.append((min_red * min_green * min_blue))

# print(games_list)
print(sum(game_power))
