extends KinematicBody2D
var perseguir:bool = false
var speed: int

func _ready():
	pass
	
func _physics_process(delta):
	var motion = Vector2.ZERO
	_detected()
	if perseguir:#condicionamos la velocidad de caminar según la posicion que se encuentra el sprite
		$movPlayer.play("walk")
		speed = 75
		if $Sprite.rotation_degrees == 0:
			motion.y = -speed
		if $Sprite.rotation_degrees == -180:
			motion.y = speed
		if $Sprite.rotation_degrees == 90:
			motion.x = speed
		if $Sprite.rotation_degrees == -90:
			motion.x = -speed
		motion = move_and_slide(motion)
	pass

func _detected():#funcion para detectar rotacion de sprite segun la colision de sus raycast
	if $left.is_colliding():
		var obj = $left.get_collider()
		if obj.is_in_group("player"):
			$Sprite.rotation_degrees = 90
			perseguir = true
	else:
		perseguir = false

	if $right.is_colliding():
		var obj = $right.get_collider()
		if obj.is_in_group("player"):
			$Sprite.rotation_degrees = -90
			perseguir = true
			

	if $up.is_colliding():
		var obj = $up.get_collider()
		if obj.is_in_group("player"):
			$Sprite.rotation_degrees = 0
			perseguir = true

	if $down.is_colliding():
		var obj = $down.get_collider()
		if obj.is_in_group("player") :
			$Sprite.rotation_degrees = -180
			perseguir = true
