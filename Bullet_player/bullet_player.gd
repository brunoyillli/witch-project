extends Area2D

var vel = 600
var dir = Vector2(0 , 0)


func _ready():
	#removido a adição de grupo, movida para o proprio player
	pass
	
func _physics_process(delta):
	translate(dir * vel * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#Função para dar o dano 
func _on_bullet_player_area_entered(area):
	area.damage(1)
	queue_free()
