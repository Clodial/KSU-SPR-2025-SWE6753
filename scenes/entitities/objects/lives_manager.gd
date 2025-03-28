extends Node

var lives = 3


func ready():
	var player = $"../Player"
	var player2 = $"../Player2"
	
	if player or player2:
		player.connect("player_lost_life", Callable(self, "_on_player_lost_life"))
	else:
		print("Player node not found!")

func lose_life():
	if lives > 0:
		lives -= 1
		print("Lives Remaining: " + str(lives))

func _on_player_lost_life() -> void:
	lose_life()


func _on_player_2_lost_life() -> void:
	lose_life() # Replace with function body.
