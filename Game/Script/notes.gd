extends Control

@onready var labels_list = $TextureRect/VBoxContainer/HBoxContainer/VBoxContainer

func _ready():
	load_notes()

func load_notes():
	load_clues()
	load_achivments()

func load_clues():
	var old_labels = labels_list.get_children()
	for label in old_labels:
		labels_list.remove_child(label)
		label.queue_free()
	for clue in Globals.clues:
		add_lable(clue)

func add_lable(clue):
	var lable = Label.new()
	lable.text = clue
	lable.add_theme_color_override("font_color", Color(0.11, 0.11, 0.11))
	lable.add_theme_font_size_override("font_size", 40)
	labels_list.add_child(lable)

func load_achivments():
	for achivment in Globals.achivments:
		add_achivment(achivment)

func add_achivment(_achivment):
	pass
