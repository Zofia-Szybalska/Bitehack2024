extends Node

@export var max_clues: int = 5
var curr_clues = 0
var collected_stickers = 0
var caugth = false

var clues = []
var achivments = []

func remove_clue():
	if curr_clues == 0:
		add_achivment(load("res://Achievements/1.tres"))
	curr_clues += 1
	if curr_clues == 5:
		add_achivment(load("res://Achievements/3.tres"))

func add_clue(clue):
	clues.append(clue)

func add_achivment(achivment: achievement):
	achivments.append(achivment)

func add_sticker():
	collected_stickers += 1
	if collected_stickers == 5:
		achivments.append(load("res://Achievements/5.tres"))
