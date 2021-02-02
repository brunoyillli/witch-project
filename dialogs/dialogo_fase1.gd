extends Node

var time = 0 
var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
var semaforo = true

func _process(_delta):
	
	time = get_tree().get_root().get_node("estage_1/timeGame").time

func dialog():
	if dialog == null:
		dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	if dialog == null and get_tree().paused:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
	pause()
	dialog.dialog_script = [
		{
			'background': "res://addons/dialogs/Images/background/placeholder-2.png"
		},
		{
			'character': 'Misaki Anri.',
			'position': 'center',
			'text':'Acho melhor eu derrotar quem está por trás dessa confusão!'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': '???',
			'position': 'center',
			'text':'Oh, nós temos visitantes!'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Oh, nós temos visitantes!'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Espere um segundo, vou pegar um chá'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Misaki Anri',
			'position': 'center',
			'text':'Você poderia me dizer o que realmente deseja fazer deixando esses yokais e espíritos tão irritadas? '
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Bom, não sei exatamente o que está acontecendo...'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune',
			'position': 'center',
			'text':'Mas se quiser realmente saber, terá que ir me batendo!!'
		},
	]
	add_child(dialog)
	
func dialog2():
	if dialog == null and get_tree().paused:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
	pause()
	dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.dialog_script = [
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Então? o que estávamos falando mesmo?'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Misaki Anri.',
			'position': 'center',
			'text':'Bom, você vê todos esses espíritos e yokai por aí irritados? O que é isso?'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Os yokais neste estado estão sobre um feitiço e os espíritos foram invocados através de uma grande oração magica, por mais estranho que pareça, não estão relacionados com os yokais e espíritos daqui.'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Misaki Anri',
			'position': 'center',
			'text':'Entendo, então foi um erro vir aqui.'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Vou te dar uma dica, a colina atrás do templo yokai é realmente suspeita.'
		},
	]
	add_child(dialog)
	
func pause():
	#var new_pause_state = not get_tree().get_root().get_node("estage_1/timeGame").paused
	#get_tree().get_root().get_node("estage_1/timeGame").paused = new_pause_state
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
