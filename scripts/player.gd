extends KinematicBody2D

var movespeed = 70
var timeLight = 40
var lifePlayer = 3
var getKey:bool = false
onready var light = get_node("Light2D")
onready var soundHeart = $sound/heartBeat
onready var soundHit = $sound/hitAttack
onready var soundEnergy = $sound/pickUpEnergy
onready var soundHealth = $sound/pickUpHealth
onready var soundKey = $sound/pickUpKey

func _ready():
	get_tree().get_nodes_in_group("tiempoEnergy")[0].text = String(timeLight)
	get_tree().get_nodes_in_group("lifeCount")[0].text = String(lifePlayer)
	light.enabled = false
	if Global.fx:
		soundHeart.play()
	pass # Replace with function body.

func _physics_process(delta):
	soundEfect()
	nextLevel()
	var motion = Vector2()
	#movimientos del player
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
		$Sprite.rotation_degrees = -90
		$Animation.play("walk")
	elif Input.is_action_pressed("ui_down"):
		$Sprite.rotation_degrees = 90
		motion.y += 1
		$Animation.play("walk")
	elif Input.is_action_pressed("ui_right"):
		$Sprite.rotation_degrees = 360
		motion.x += 1
		$Animation.play("walk")
	elif Input.is_action_pressed("ui_left"):
		$Sprite.rotation_degrees = 180
		motion.x -= 1
		$Animation.play("walk")
	else:
		$Animation.play("idle")

	motion = motion.normalized()
	motion = move_and_slide(motion*movespeed)
	
	if Input.is_action_just_pressed("ui_light") and timeLight >= 1:#input para el encendido de la linterna
			if light.enabled == true:
				light.enabled = false
			else:
				light.enabled = true

func _on_Timer_timeout():#timer para el tiempos de la linterna
	get_tree().get_nodes_in_group("tiempoEnergy")[0].text = String(timeLight)
	if timeLight == 0:
		timeLight = 0
		light.enabled = false
	else:
		timeLight -=1
	
func soundEfect():#controlamos la velocidad del latido a medida que pierde vidas
	if lifePlayer == 2 and Global.fx:
		soundHeart.pitch_scale = 1.5
	if lifePlayer == 1 and Global.fx:
		soundHeart.pitch_scale = 2

func _on_Area2D_area_entered(area):#controlamos la colision del player con las distintas areas
	if area.is_in_group("energy"):
		timeLight = 40
		if Global.fx:
			soundEnergy.play()
		area.queue_free()
	if area.is_in_group("enemy"):
		lifePlayer -= 1
		if Global.fx:
			soundHit.play()
		get_tree().get_nodes_in_group("lifeCount")[0].text = String(lifePlayer)
		if lifePlayer < 1:
			var player = get_tree().get_nodes_in_group("player")[0]
			player.queue_free()
			get_tree().change_scene("res://scenes/GameOver.tscn")
	if area.is_in_group("health"):
		lifePlayer += 1
		if Global.fx:
			soundHealth.play()
		get_tree().get_nodes_in_group("lifeCount")[0].text = String(lifePlayer)
		if soundHeart.pitch_scale > 1 and Global.fx:
			soundHeart.pitch_scale -= 0.5
		area.queue_free()
	if area.is_in_group("key"):
		getKey = true
		if Global.fx:
			soundKey.play()
		area.queue_free()

func nextLevel():#condicion de ganador
	if $nextLevel.is_colliding():
		var obj = $nextLevel.get_collider()
		if obj.is_in_group("nextLevel"):
			get_tree().change_scene("res://scenes/level2.tscn")
		if obj.is_in_group("nextLevel") and getKey == true:
			get_tree().change_scene("res://scenes/GameWin.tscn")
