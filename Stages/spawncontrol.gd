extends Node
var time 
var stop = false

var max_index_group = 0
var init_index_group = 0

var actual_group = 0
var enemy_on = 0
var group_three = true

func _ready():
	time = get_tree().get_root().get_node("estage_1/timeGame")
	init_index_group = get_children().size()
	max_index_group = get_children().size()
	for a in max_index_group:
		get_children()[a].get_children()[0].set_process(false)
		get_children()[a].get_children()[1].set_process(false)
		get_children()[a].get_children()[2].set_process(false)
		get_children()[a].get_children()[3].set_process(false)
		get_children()[a].get_children()[4].set_process(false)
			

func _process(_delta):
	if(actual_group == 3 and group_three == true):
		group_three = false
		get_tree().get_root().get_node("estage_1/DialogoLayer/Dialogo").get_child(0).dialog()
	#quando a safra perde os spawners, ela chama a proxima.
	if actual_group <= init_index_group -1:
		if get_children()[actual_group].get_children().size() != 0:
			for a in get_children()[actual_group].get_children().size(): 
				get_children()[actual_group].get_children()[a].set_process(true)
		else:
			if get_children().size() == init_index_group:
				actual_group += 1
				stop = false
				time.start()
			else:
				time.stop()
				stop = true
	
	
