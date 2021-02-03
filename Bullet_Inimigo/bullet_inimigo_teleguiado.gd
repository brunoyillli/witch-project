extends Area2D


var dir = Vector2(0, 0)
var glow = false
export var bullet_speed = 0.3

var dash = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer/slowDash.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if glow:
		$anim.set_current_animation("glow")
		if !dash:
			position += dir * delta * bullet_speed *0.3
		else: position += dir * delta * bullet_speed 
	else:
		position += dir * delta * bullet_speed *0.3
		
func screen_exited():
	get_parent().remove_child(self)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_inimigo_teleguiado_body_entered(body):
	body.damage(1)
	queue_free()


func _on_bullet_inimigo_teleguiado_area_entered(_area):
	queue_free()


func _on_slowDash_timeout():
	dash = true
