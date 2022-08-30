extends CanvasLayer
#Menu de pausa y activacion de full Screen tomado de este video https://www.youtube.com/watch?v=WaotOuDNio8&t=3s

func _ready():
	set_visible(false)
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_paused"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused
		pass
		
func _on_ContinueButton_pressed():
	get_tree().paused = false
	set_visible(false)
	pass # Replace with function body.

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	pass # Replace with function body.
