
extends Area2D

onready var bullet_scene = preload("res://Bullet_Inimigo/giant-fairy/bullet_giant_f.tscn")
onready var player = get_tree().get_root().get_node("estage_1/player")
#depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
#no caso player
onready var mainScene = get_tree().get_root().get_node("estage_1")


var alma_azul = preload("res://Cristais/Alma_azul/alma_azul.tscn")
var alma_rosa = preload("res://Cristais/Alma_rosa/alma_rosa.tscn")

var life = 60
var mypos = Vector2(0,0)
var playerpos = Vector2(0,0)
var canShoot = true
var wait = true
var side = 1

var animacao =""
var nova_anim =""

func _ready():
	pass
	
func _physics_process(delta):
	if canShoot:
		nova_anim = "idle"
		spawn_bullets()
		canShoot = false
		$timer.start()
	if !wait:
		movimenta(delta)
		$sprite.scale.x = side
		nova_anim = "moving"
	if $waitTimer.is_stopped():
		$waitTimer.start()
		
	if position.y <64:
		position.y += 120 * delta	
	mypos = self.global_position
	playerpos = player.global_position
		
	if animacao != nova_anim:
		get_node("anim").play(nova_anim)
		animacao = nova_anim

	
func movimenta(delta):

	
	if position.x >= 480 or position.x<60:
		side = -side
		position.x += 150*side* delta
	else: 
		position.x += 150*side* delta
			
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()

func spawn_bullets():
	var b1 = bullet_scene.instance()
	b1.bullet_speed = 150
	b1.position = get_global_position()
	b1.dir = Vector2(player.global_position.x - mypos.x,player.global_position.y - mypos.y).normalized()
	mainScene.add_child(b1)
	
func _on_timer_timeout():
	canShoot = true

	
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



func _on_waitTimer_timeout():
	wait = !wait
