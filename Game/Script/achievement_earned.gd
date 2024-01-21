extends Control

@onready var texture_rect: TextureRect = $PanelContainer/MarginContainer/HBoxContainer/TextureRect
@onready var names = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Name
@onready var description = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Description

func _ready():
	Globals.achievemen_earned.connect(load_achievement)

func load_achievement(earned_achievement: achievement):
	texture_rect.texture = earned_achievement.image
	names.text = earned_achievement.name
	description.text = earned_achievement.description
	var tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", Color(1,1,1,1), 1)
	$Timer.start()


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", Color(1,1,1,0), 1)
