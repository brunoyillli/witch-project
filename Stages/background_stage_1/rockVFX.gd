extends Node2D

var verX = 0


func _process(_delta):
	if get_global_position().y <= 700:
		position.y += 0.5
		
	else: 
		global_position.y = -200
		verX = rand_range(0,600)
