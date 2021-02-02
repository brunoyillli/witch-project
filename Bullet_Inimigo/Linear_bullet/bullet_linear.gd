extends Area2D


var dir = Vector2(1, 0)

export var bullet_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y += bullet_speed * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_Linear_body_entered(body):
	body.damage(1)
	queue_free()
