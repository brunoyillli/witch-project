extends Control


var gameover
enum {RUNNING, DEAD, VICTORY}
var count = 0

func _process(delta):
	gameover = get_tree().get_root().get_node("estage_1/player").status
	if gameover == DEAD:
		if count == 0:
			count = 1
			Game_Over()

func Game_Over():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_Restart_pressed():
	Global.points = 0
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	get_tree().quit()
