extends Node

const SAVE_PATH = "user://save_file.json"
const max_health = 3
var main_progress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_progress = load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	var game_progress = {
		"section_1_health": max_health,
		"section_2_health": max_health,
		"section_3_health": max_health, 
		"available_levels": [
			"level1-1"
		]
	}
	return game_progress
	
func get_progress():
	return main_progress
	
func set_progress_add_level(level_array):
	main_progress.set("available_levels", level_array)
	return main_progress
	

func save_game() -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_dict = main_progress
	save_file.store_line(JSON.stringify(save_dict))
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return new_game()
	var load_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json = JSON.new()
	json.parse(load_file.get_line())
	var save_dict = json.get_data() as Dictionary
	return save_dict
