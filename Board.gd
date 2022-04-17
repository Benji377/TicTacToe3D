extends Node2D

var board = [0, 0, 0, 
			0, 0, 0, 
			0, 0, 0]
var player1_icon = preload("res://images/player1.png")
var player2_icon = preload("res://images/player2.png")
signal game_over(player)

# Called when the node enters the scene tree for the first time.
func _ready():
	abilitate_buttons(false)

# Function to determine whose player turn it is
func player_one_turn():
	var player1_turn = true
	if (board.count(1) <= board.count(2)):
		# Its player1 turn
		player1_turn = true
	else:
		player1_turn = false
	return player1_turn

# Function to add the icon to the clicked button
func set_button_icon(button_id, player):
	var icon = null
	if (player == 1):
		icon = player1_icon
	else:
		icon = player2_icon
	match button_id:
		0:
			$GridContainer/Button.icon = icon
		1:
			$GridContainer/Button1.icon = icon
		2:
			$GridContainer/Button2.icon = icon
		3:
			$GridContainer/Button3.icon = icon
		4:
			$GridContainer/Button4.icon = icon
		5:
			$GridContainer/Button5.icon = icon
		6:
			$GridContainer/Button6.icon = icon
		7:
			$GridContainer/Button7.icon = icon
		8:
			$GridContainer/Button8.icon = icon

# Function to check if someone won
func get_winner():
	var winner = 0
	print(board)
	if (board[0] == board[1] && board[1] == board[2]):
		winner = board[0]
	elif (board[3] == board[4] && board[4] == board[5]):
		winner = board[3]
	elif (board[6] == board[7] && board[7] == board[8]):
		winner = board[6]
	elif (board[0] == board[3] && board[3] == board[6]):
		winner = board[0]
	elif (board[1] == board[4] && board[4] == board[7]):
		winner = board[1]
	elif (board[2] == board[5] && board[5] == board[8]):
		winner = board[2]
	elif (board[0] == board[4] && board[4] == board[8]):
		winner = board[0]
	elif (board[2] == board[4] && board[4] == board[6]):
		winner = board[2]
	elif (board.count(1) +  board.count(2) == 9):
		winner = -1
	return winner

# Enable / disable all buttons
func abilitate_buttons(abiled):
	var abil = !abiled
	$GridContainer/Button.disabled = abil
	$GridContainer/Button1.disabled = abil
	$GridContainer/Button2.disabled = abil
	$GridContainer/Button3.disabled = abil
	$GridContainer/Button4.disabled = abil
	$GridContainer/Button5.disabled = abil
	$GridContainer/Button6.disabled = abil
	$GridContainer/Button7.disabled = abil
	$GridContainer/Button8.disabled = abil

# Function to reset everything
func reset_board():
	board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	$GridContainer/Button.icon = null
	$GridContainer/Button1.icon = null
	$GridContainer/Button2.icon = null
	$GridContainer/Button3.icon = null
	$GridContainer/Button4.icon = null
	$GridContainer/Button5.icon = null
	$GridContainer/Button6.icon = null
	$GridContainer/Button7.icon = null
	$GridContainer/Button8.icon = null

# Function to insert entry from clicked button into array
func _on_Button_pressed(extra_arg_0):
	# argument is the position of the button
	if (board[extra_arg_0] == 0):
		if (player_one_turn()):
			board[extra_arg_0] = 1
			set_button_icon(extra_arg_0, 1)
			if (get_winner() > 0):
				print("Player " + str(get_winner()) + " has won!")
				emit_signal("game_over", get_winner())
				abilitate_buttons(false)
			elif (get_winner() < 0):
				print("Nobody won")
				emit_signal("game_over", get_winner())
				abilitate_buttons(false)
		else:
			board[extra_arg_0] = 2
			set_button_icon(extra_arg_0, 2)
			if (get_winner() > 0):
				print("Player " + str(get_winner()) + " has won!")
				emit_signal("game_over", get_winner())
				abilitate_buttons(false)
			elif (get_winner() < 0):
				print("Nobody won")
				emit_signal("game_over", get_winner())
				abilitate_buttons(false)

