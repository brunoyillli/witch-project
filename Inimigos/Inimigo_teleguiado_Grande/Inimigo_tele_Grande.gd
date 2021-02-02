extends Area2D

onready var bullet_scene = preload("res://Bullet_Inimigo/Grande_teleguiado/teleguiado_Grande.tscn")

onready var player = get_tree().get_root().get_node("estage_1/player")
onready var mainScene = get_tree().get_root().get_node("estage_1")
var alma_azul = preload("res://Cristais/Alma_azul/alma_azul.tscn")
var alma_rosa = preload("res://Cristais/Alma_rosa/alma_rosa.tscn")
#depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
#no caso player


var mypos = Vector2(0,0)
var playerpos = Vector2(0,0)
var life = 75

func _ready():
	$Timer.start()
	
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()



func _process(delta):
	mypos = self.global_position
	playerpos = player.global_position
	
	move_local_x(1 * delta)
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()
	
func spawn_bullets():
	
	var b1 = bullet_scene.instance()
	get_parent().add_child(b1)
	b1.bullet_speed = 300
	b1.position = self.position
	b1.dir = Vector2(playerpos.x- mypos.x, playerpos.y-mypos.y).normalized()

func _on_Timer_timeout():
	spawn_bullets()

func damage(amount: int):
	life -= amount
	if life<= 0:
		var drop = randi() % 4 # 25% de chance de dropar a vida
		if drop == 0:
			var pick_rosa = alma_rosa.instance()
			pick_rosa.position = Vector2(self.position.x , (self.position.y - 10))
			mainScene.call_deferred("add_child", pick_rosa)
		var pick_azul = alma_azul.instance()
		pick_azul.position = self.position
		mainScene.call_deferred("add_child", pick_azul)
		queue_free()
