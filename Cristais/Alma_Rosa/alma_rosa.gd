extends Area2D

onready var player = get_tree().get_root().get_node("estage_1/player")

var vel = 150
var dir = Vector2(0 , 1)
var limit = 1

var playerPos = Vector2(0,0)
var myPos = Vector2(0,0)
var canChase = false

func _ready():
	pass
	
func _physics_process(delta):
	
	playerPos = player.get_global_position()
	myPos = get_global_position()
	if canChase:
		vel = 350
		movimenta(delta)
	else:
		position.y += vel * delta
		
func movimenta(delta): 
	if playerPos.y - myPos.y > limit: #desce
		position.y += vel * delta 
		if playerPos.x - myPos.x > limit:
			position.x += vel * delta #direita
		elif playerPos.x - myPos.x < limit:
			position.x -= vel * delta #direita
			
	elif playerPos.y - myPos.y < limit: #sobe
		position.y -= vel * delta 
		if playerPos.x - myPos.x > limit:
			position.x += vel * delta #direita
		elif playerPos.x - myPos.x < limit:
			position.x -= vel * delta #direita

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Alma_rosa_body_entered(body):
	if body.get_collision_layer() == 1:
		body.health += 0.25
		queue_free()


func _on_magnet_body_entered(_body):
	canChase = true
