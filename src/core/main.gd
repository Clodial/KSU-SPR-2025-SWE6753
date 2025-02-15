extends Node

@export var start_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_game_level = start_level.instantiate();
	add_child(start_game_level);
	$SceneManager.SetCurrentScene(start_game_level);



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$SceneManager.RestartScene(); # Replace with function body.
