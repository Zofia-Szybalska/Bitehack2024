extends Node

@export var max_clues: int = 3
var curr_clues = 0
var collected_stickers = 0
var caugth = false
var message = "Usuń dowody swojej zbrodni, ale uważaj, żeby nik cię nie zauważył, bo może się to źle skończyć, pośpiesz się."
var max_achievements = 4
var all_achievements = false
var collected_achievements = 0
var player: CharacterBody3D
var a_1 = false
var a_2 = false

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
	get_tree().reload_current_scene()

func remove_clue():
	if curr_clues == 0 and !a_1:
		a_1 = true
		add_achivment(load("res://Achievements/1.tres"))
	curr_clues += 1
	if curr_clues == max_clues and !a_2:
		a_2 = true
		add_achivment(load("res://Achievements/3.tres"))
		reset("Usunąłeś wszystkie dowody, które cię pogrążały, brawo ujdzie ci to płazem, ale niestety czas się cofnął, ciekawe. Może jednak znajdziesz tu jescze coś interesującego?")

func add_clue(clue):
	clues.append(clue)

func add_achivment(achivment: achievement):
	achivments.append(achivment)
	achievemen_earned.emit(achivment)
	collected_achievements += 1
	if collected_achievements == max_achievements:
		get_tree().change_scene_to_file("res://Scenes/You won.tscn")

func add_sticker():
	player.naklejka.play()
	collected_stickers += 1
	if collected_stickers == 5:
		achivments.append(load("res://Achievements/5.tres"))
