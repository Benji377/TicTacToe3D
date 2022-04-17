extends Node

var board = preload("res://Board.tscn").instance()
var layers = 3
var current_layer = 0
var board_layer = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(layers):
		board_layer.append(preload("res://Board.tscn").instance())
		board_layer[i].add_to_group("boards")
		board_layer[i].position.y = 250
	add_child(board_layer[current_layer])
	

# Starts the game
func _on_Start_pressed():
	get_tree().call_group("boards", "reset_board")
	get_tree().call_group("boards", "abilitate_buttons(true)")
	$Start.visible = false
	$Winner.text = "Waiting for a winner..."

# When the Board tells the game that someone won
func _on_Board_game_over(player):
	print(player)
	$Start.visible = true
	if (player == 1):
		$Winner.text = "O won the game!"
	elif (player == 2):
		$Winner.text = "X won the game!"
	else:
		$Winner.text = "Nobody won"


# Changes the Layer forward or backward
func _on_changeLayer(extra_arg_0):
	remove_child(board_layer[current_layer])
	current_layer += extra_arg_0
	if (current_layer >= board_layer.size()):
		current_layer = 0
		$Layers.text = "Layer " + str(current_layer)
	
	board = board_layer[current_layer]
	board.abilitate_buttons(true)
	add_child(board)
