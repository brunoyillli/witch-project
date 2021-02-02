extends KinematicBody2D

var pre_bullet = preload("res://Bullet_player/bullet_player.tscn")
var pre_bullet2 = preload("res://Bullet_player/bullet_player_2.tscn")
onready var joystick = get_node("Hud/Joystick/Joystick_button")

var speed = 150

var vel := Vector2(0, 0)

var max_power = 8
var power = 1
var power_frag = 0
var max_health = 5
var health = 3

var newDeltaX
var newDeltaY
var deltaX
var deltaY
var touchPos = Vector2()
var areaEnt = false

enum {RUNNING, DEAD, VICTORY}
var status = RUNNING

#shoot timer
var canShoot = true
var canHurt = true

func _ready():
	add_to_group("player")
	if(OS.get_name() == "Windows"):
		$Hud/Joystick.hide()
		
# warning-ignore:unused_argument
func _physics_process(delta):
	
	powerFix()
		
	if status == RUNNING:
		running()
#	elif status == DEAD:
#		dead(delta)


#func _input(event):
#	if areaEnt == true:
#		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
#			var bullet = pre_bullet.instance()
#			bullet.global_position = $muzzle.global_position
#			get_parent().add_child(bullet)
#			touchPos = event.get_position()
#			deltaX = touchPos.x - position.x
#			deltaY = touchPos.y - position.y
#	pass
	
#func _process(delta):
	#move_and_slide(joystick.get_value() * speed)
#	pass
func powerFix():
	if power_frag >= 0 and power_frag < 8:
		power = 1
	elif power_frag >= 8 and power_frag < 16:
		power = 2
	elif power_frag >= 16:
		power = 3
func running():
	var dirVec := Vector2(0, 0)
	
	# verifica se tem tantos elementos no grupo bullet
	if get_tree().get_nodes_in_group("bullet_player").size() <= 64:
		attack()
				
	if Input.is_action_pressed("ui_ataque") or areaEnt == true:
		$player_shape.visible = true
	else:
		$player_shape.visible = false
		
	if Input.is_action_pressed('ui_right'):
		dirVec.x = 1

	if Input.is_action_pressed('ui_left'):
		dirVec.x = -1

	if Input.is_action_pressed('ui_down'):
		dirVec.y = 1

	if Input.is_action_pressed('ui_up'):
		dirVec.y = -1
		
	vel = dirVec.normalized() * speed
	vel = move_and_slide(vel) 
## warning-ignore:return_value_discarded
#	move_and_slide( Vector2(dir_x , dir_y) * speed)
func attack():
	match power:
		1:
			if (Input.is_action_pressed("ui_ataque") or areaEnt == true) and canShoot:
				var bullet = pre_bullet.instance()
				bullet.add_to_group("bullet_player") #add no grupo 
				bullet.global_position = $muzzle.global_position
				bullet.dir = Vector2(0,-1)
				get_parent().add_child(bullet) #Nao pode atirar, inicia o timer pra poder atirar dnv
				canShoot=false
				shootSFX()
				$shootTimer.start()
		2:
			if (Input.is_action_pressed("ui_ataque") or areaEnt == true) and canShoot:
				var bullet = pre_bullet.instance()
				bullet.add_to_group("bullet_player") #add no grupo 
				bullet.global_position = $muzzle.global_position
				bullet.dir = Vector2(0,-1)
				get_parent().add_child(bullet) #Nao pode atirar, inicia o timer pra poder atirar dnv
				var bullet2 = pre_bullet.instance()
				bullet2.add_to_group("bullet_player") #add no grupo 
				bullet2.global_position = $muzzle.global_position
				bullet2.dir = Vector2(cos(deg2rad(260)),sin(deg2rad(260)))
				get_parent().add_child(bullet2)
				var bullet3 = pre_bullet.instance()
				bullet3.add_to_group("bullet_player") #add no grupo 
				bullet3.global_position = $muzzle.global_position
				bullet3.dir = Vector2(cos(deg2rad(280)),sin(deg2rad(280)))
				get_parent().add_child(bullet3)
				canShoot=false
				shootSFX()
				$shootTimer.start()
		3:
			if (Input.is_action_pressed("ui_ataque") or areaEnt == true) and canShoot:
				var bullet = pre_bullet.instance()
				bullet.add_to_group("bullet_player") #add no grupo 
				bullet.global_position = $muzzle.global_position
				bullet.dir = Vector2(0,-1)
				get_parent().add_child(bullet) #Nao pode atirar, inicia o timer pra poder atirar dnv
				var bullet2 = pre_bullet.instance()
				bullet2.add_to_group("bullet_player") #add no grupo 
				bullet2.global_position = $muzzle.global_position
				bullet2.dir = Vector2(cos(deg2rad(250)),sin(deg2rad(250)))
				get_parent().add_child(bullet2)
				var bullet3 = pre_bullet.instance()
				bullet3.add_to_group("bullet_player") #add no grupo 
				bullet3.global_position = $muzzle.global_position
				bullet3.dir = Vector2(cos(deg2rad(290)),sin(deg2rad(290)))
				get_parent().add_child(bullet3)
				if get_tree().get_nodes_in_group("bullet_player2").size() <= 4:
					var bullet4 = pre_bullet2.instance()
					bullet4.add_to_group("bullet_player2") #add no grupo 
					bullet4.global_position = $muzzle.global_position
					bullet4.dir = Vector2(cos(deg2rad(280)),sin(deg2rad(280)))
					get_parent().add_child(bullet4)
					var bullet5 = pre_bullet2.instance()
					bullet5.add_to_group("bullet_player2") #add no grupo 
					bullet5.global_position = $muzzle.global_position
					bullet5.dir = Vector2(cos(deg2rad(260)),sin(deg2rad(260)))
					get_parent().add_child(bullet5)
				canShoot=false
				shootSFX()
				$shootTimer.start()
		
func damage(qtd):
	if health > 0:
		if canHurt:
			health -= qtd
			canHurt = false
			$imune.start()
			$animImun.play("imune")
	else:
		killed()
	
func killed():
	if status != DEAD:
		status = DEAD

func shootSFX():
	if !$shootSFX.is_playing():
		$shootSFX.play()


func _on_TouchScreenButton_pressed():
	areaEnt = true


func _on_TouchScreenButton_released():
	areaEnt = false


func _on_shootTimer_timeout():
	canShoot = true


func _on_imune_timeout():
	$animImun.play("normal")
	canHurt = true
