extends Sprite




func _process(_delta):
	if get_global_position().y <= 1200:
		position.y += 0.33
		
	else: 
		global_position.y = -200
