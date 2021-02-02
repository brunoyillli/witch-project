extends Node2D

onready var linear_scene =preload("res://Inimigos/Inimigo_linear/Inimigo_linear.tscn")
onready var teleguiado_Grande_scene = preload("res://Inimigos/Inimigo_teleguiado_Grande/Inimigo_tele_Grande.tscn")
onready var enemy_scene = preload("res://Inimigos/inimigo_teleguiado.tscn")
onready var kitsune = preload("res://Inimigos/kitsune/kitsune.tscn")
onready var giant_fairy = preload("res://Inimigos/Giant-Fairy/Giant-Fairy.tscn")
onready var boss01 = preload("res://Bosses/Boss_1.tscn")


var wave = 1
var spawnTimer = 0
var spawnPosY = 0
var spawnPosX =0

export var triggerSpawn = [2,9.5,18,27,33] #tempos que spawnarão em segundos
export var spawnType = [1,2,1,3,1] #tipo de criatura que sera spawanada
var timeTimer = 0
var index = 0 #valor do slot dos arrays
var time = 0 #tempo da cena
var mainScene = ""


func _ready():
	spawnPosY = get_tree().get_root().get_node("estage_1/spawnPos").get_global_position().y
	spawnPosX = get_global_position().x
	mainScene = get_tree().get_root().get_node("estage_1/spawn")
##	for i in range(3):
##		var enemy = enemy_scene[0].instance()
##		randomize()
##		enemy.position.x = rand_range(60, 500)
##		enemy.position.y = -100
##		add_child(enemy)
	
func _process(_delta):
	if triggerSpawn[index] > 3600:
		queue_free()
	#atualiza o tempo do script
	time = get_tree().get_root().get_node("estage_1/timeGame").time
	canSpawn()
#função se pode spawnar, analisa o tempo do script, 
#com os tempos predeterminados do array
func canSpawn():
	if index <= (triggerSpawn.size())-1: #limitador pra n pegar slot do array que não existe
		if time >= triggerSpawn[index]:
			wave = spawnType[index]
			spawn()
			index += 1


func spawn():
	if triggerSpawn[index]<3600:
		match wave:
			1:
				var enemy = linear_scene.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
			2:
				var enemy = teleguiado_Grande_scene.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
			3:
				var enemy = enemy_scene.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
			4:
				var enemy = kitsune.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
			5:
				var enemy = giant_fairy.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
			6:
				var enemy = boss01.instance()
				enemy.set_global_position(Vector2(spawnPosX,spawnPosY))
				mainScene.add_child(enemy)
