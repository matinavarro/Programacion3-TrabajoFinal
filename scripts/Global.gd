extends Node

var fx = true
var music = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#Se establece Tecla R para reiniciar el juego
func _input(event):
	if event.is_action_pressed("ui_back_menu"):
		get_tree().change_scene("res://scenes/menu.tscn")
