extends Area2D

onready var bullet_scene = load("res://Bullet_Inimigo/Linear_bullet/bullet_linear.tscn")

#onready var player = get_parent().get_parent().get_node("player")
##depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
##no caso player
onready var alma_azul = preload("res://Cristais/Alma_azul/alma_azul.tscn")
onready var alma_rosa = preload("res://Cristais/Alma_rosa/alma_rosa.tscn")
onready var mainScene = get_tree().get_root().get_node("estage_1")

onready var leftGun := $FiringPositions/LeftGun
onready var rightGun := $FiringPositions/RightGun

var life = 60

func _ready():
	$Timer.start()
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()



func _process(delta):
	move_local_x(1 * delta)
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()
	
func spawn_bullets():
		var b1 = bullet_scene.instance()
		b1.bullet_speed = 300
		b1.position = leftGun.global_position
		var b2 = bullet_scene.instance()
		b2.bullet_speed = 300
		b2.position = rightGun.global_position
		get_tree().current_scene.add_child(b2)
		get_tree().current_scene.add_child(b1)
		

func _on_Timer_timeout():
	spawn_bullets()

func damage(amount: int):
	if life > 0:
		life -= amount
	else:
		var drop = randi() % 4 # 25% de chance de dropar a vida
		if drop == 0:
			var pick_rosa = alma_rosa.instance()
			pick_rosa.position = Vector2(self.position.x , (self.position.y - 10))
			mainScene.call_deferred("add_child", pick_rosa)
		var pick_azul = alma_azul.instance()
		pick_azul.set_global_position(Vector2(self.position.x , (self.position.y)))
		mainScene.call_deferred("add_child", pick_azul)
		queue_free()
