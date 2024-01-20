extends Node

var collected_stickers = 0

var clues = []
var achivments = []

func add_clue(clue):
	clues.append(clue)

func add_achivment(achivment):
	achivments.append(achivment)

func add_sticker():
	collected_stickers += 1
	if collected_stickers == 5:
		achivments.append("naklejki")
