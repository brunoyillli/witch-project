extends Node2D


onready var bullet_scene = load("res://Bullet_Inimigo/bullet_inimigo_teleguiado.tscn")

onready var player = get_tree().get_root().get_node("estage_1/player")
#depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
#no caso player

var alma_azul = preload("res://Cristais/Alma_azul/alma_azul.tscn")
var alma_rosa = preload("res://Cristais/Alma_rosa/alma_rosa.tscn")
var alma_verde = preload("res://Cristais/Alma_verde/alma_verde.tscn")
onready var mainScene = get_tree().get_root().get_node("estage_1")

var time = 0

var speed = 64
var state =""
var side = 0

var life = 35
var mypos = Vector2(0,0)
var playerpos = Vector2(0,0)
func _ready():
	side = randi() % 2 + 1
	$Timer.start()
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()
	state = "goDOWN"


func _process(delta):
	time = get_tree().get_root().get_node("estage_1/timeGame").time
	
	mypos = self.global_position
	playerpos = player.global_position
	move_local_x(1 * delta)
	
	#estados de direção
	if time <=30:
		state = "goDOWN"
	else:
		speed = 128
		position2state()
	updateState(delta)
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()
	
	if life<= 0:
		var drop = randi() % 4 # 25% de chance de dropar a vida
		if drop == 0:
			var pick_rosa = alma_rosa.instance()
			pick_rosa.position = Vector2(self.position.x , (self.position.y - 10))
			mainScene.call_deferred("add_child", pick_rosa)
		var pick_azul = alma_azul.instance()
		pick_azul.position = self.position
		mainScene.call_deferred("add_child", pick_azul)
		var pick_verde = alma_verde.instance()
		pick_verde.position = self.position
		mainScene.call_deferred("add_child", pick_verde)
		queue_free()
		
func position2state():
	if position.y >= 550:
		
		if side == 1:
			if	position.x >= 60:
				state = selectSIDE()
			else: state = "goUP"
			
		elif side == 2:
			if	position.x <= 480:
				state = selectSIDE()
			else: state = "goUP"

	elif position.y <= 50:
		
		if side==1:
			if position.x <= 480 and state == "goUP":
				state = inverseSIDE()
			else: 
				if position.x >= 480:
					state = "goDOWN"
					
		elif side==2:
			if position.x >= 60 and state == "goUP":
				state = inverseSIDE()
			else: 
				if position.x <= 60:
					state = "goDOWN"
					
func inverseSIDE():
	match side:
		1:
			return "goRIGHT"
		2:
			return "goLEFT"

func selectSIDE():
	match side:
		1:
			return "goLEFT"
		2:
			return "goRIGHT"

func updateState(delta):
	match state:
		"goDOWN":
			position.y += speed * delta 
		"goUP":
			position.y -= speed * delta
		"goLEFT":
			position.x -= speed * delta * 0.6
		"goRIGHT":
			position.x += speed * delta * 0.6

func spawn_bullets():
	var b1 = bullet_scene.instance()
	
	get_parent().add_child(b1)
	b1.bullet_speed = 300
	b1.position = self.position
	b1.dir = Vector2(playerpos.x- mypos.x, playerpos.y-mypos.y).normalized()

func _on_Timer_timeout():
	spawn_bullets()

func _on_Area2D_area_entered(_area):
	#life -= 1
	if life <= 0:
		queue_free()
