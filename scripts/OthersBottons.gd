extends Node2D

func _ready():
	$Menu.grab_focus()#grab_focus funciona para poder utilizar el teclado para eleccion de botones
	$Quit.grab_focus()

func _on_Menu_pressed():#realizamos cambio de escena hacia menu
	get_tree().change_scene("res://scenes/LoadingSceneTransition.tscn")

func _on_Quit_pressed():#salimos del juego
	get_tree().quit()
