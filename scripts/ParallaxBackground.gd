extends ParallaxBackground
#aplciacion de parallax se tomo de este video https://www.youtube.com/watch?v=RbvteTMELL8&t=1274s
var DIR = Vector2(1,0) #solamente le agregue movimiento sobre el eje x 

var speed = 30

func _physics_process(delta):
	scroll_base_offset += DIR * speed * delta #
