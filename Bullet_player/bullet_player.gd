extends Area2D

var vel = 600
var dir = Vector2(0 , 0)


func _ready():
	$bullet_blue.rotation_degrees = rand_range(0,360)
	
func _physics_process(delta):
	translate(dir * vel * delta)
	$bullet_blue.rotation_degrees += 12


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#Função para dar o dano 
func _on_bullet_player_area_entered(area):
	area.damage(7)
	queue_free()
