extends Area2D


func _on_Goal_body_entered(body: Node2D) -> void:
	if body.name == "Player" or "Player2":
		print("Collision has occured!")
