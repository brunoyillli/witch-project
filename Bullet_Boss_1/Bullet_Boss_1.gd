extends Area2D


export var bullet_speed = 0.06
export var final_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position += Vector2(1, 0).rotated(self.rotation)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_Boss_1_body_entered(body):
	body.damage(1)
	queue_free()


func _on_Bullet_Boss_1_area_entered(_area):
	queue_free()
