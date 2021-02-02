extends Control

#func _ready():
#	$TextureButton.grab_focus()
#
#func _physics_process(delta):
#	if $TextureButton.is_hovered() == true:
#		$TextureButton.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state


func _on_Continue_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible


func _on_Quit_pressed():
	get_tree().quit()
	
