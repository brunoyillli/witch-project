extends Area2D

var vel = 600
var dir = Vector2(0 , 0)
var myPos = Vector2(0,0)
var enemyPos = Vector2(0,0)
var chase = false

func _ready():
	pass
	
func _physics_process(delta):
	myPos = get_global_position()
	if chase:
		if enemyPos.y > myPos.y:
			position.y += vel * delta
		elif enemyPos.y < myPos.y:
			position.y -= vel * delta
		if enemyPos.x > myPos.x:
			position.x += vel * delta
		elif enemyPos.x < myPos.x:
			position.x -= vel * delta
	else:
		translate(dir * vel * delta)
	rotation_degrees += delta * 20
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_magnet_area_entered(area):
	chase = true
	enemyPos = area.get_global_position()
	


func _on_bullet2_player_area_entered(area):
	area.damage(1)
	queue_free()


func _on_Timer_timeout():
	queue_free()
