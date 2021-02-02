extends Node

var points = 0
var highscore = 0 setget set_highscore
const filepath = "user://highscore.data"
var custom_variables = {}

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
	
func _ready():
	load_bestscore()
	pass
	
func load_bestscore():
	var file = File.new()
	if not file.file_exists(filepath): return
	file.open(filepath, File.READ)
	highscore = file.get_var()
	file.close()
	pass
	
func save_bestscore():
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_var(highscore)
	file.close()
	pass

func set_highscore(new_value):
	highscore = new_value
	save_bestscore()
	pass
