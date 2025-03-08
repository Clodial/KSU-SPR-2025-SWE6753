extends Area2D

signal player_touch
signal player_out

func _on_Goal_body_entered(body: Node2D) -> void:
	if body.name == "Player" or "Player2":
		print("Collision has occured!")
	player_touch.emit()
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player" or "Player2":
		print("Collision has stopped!")
	player_out.emit()
