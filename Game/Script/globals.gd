extends Node

@export var max_clues: int = 5
var curr_clues = 0
var collected_stickers = 0
var caugth = false
var message = "Usuń dowody swojej zbrodni, ale uważaj, żeby nik cię nie zauważył, bo może się to źle skończyć, pośpiesz się."
var max_achievements = 5
var all_achievements = false
var collected_achievements = 0

var clues = []
var achivments = []
signal achievemen_earned(earned_achevement: achievement)

func reset(reset_message):
	var knifes = get_tree().get_nodes_in_group("knife")
	for knife in knifes:
		knife.queue_free()
	if all_achievements:
		pass
	collected_stickers = 0
	curr_clues = 0
	clues = []
	message = reset_message

func remove_clue():
	if curr_clues == 0:
		add_achivment(load("res://Achievements/1.tres"))
	curr_clues += 1
	if curr_clues == 5:
		add_achivment(load("res://Achievements/3.tres"))
		reset("Usunąłeś wszystkie dowody, które cię pogrążały, brawo ujdzie ci to płazem, ale niestety czas się cofnął, ciekawe. Może jednak znajdziesz tu jescze coś interesującego?")

func add_clue(clue):
	clues.append(clue)

func add_achivment(achivment: achievement):
	achivments.append(achivment)
	achievemen_earned.emit(achivment)
	collected_achievements += 1
	if collected_achievements == max_achievements:
		all_achievements = true
	

func add_sticker():
	collected_stickers += 1
	if collected_stickers == 5:
		achivments.append(load("res://Achievements/5.tres"))
