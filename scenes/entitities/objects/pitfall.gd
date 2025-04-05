extends Area2D


func _on_Pitfall_body_entered(body: Node2D) -> void:
	#get_tree().reload_current_scene()
	print("Pitfall hit by: " + body.name)
