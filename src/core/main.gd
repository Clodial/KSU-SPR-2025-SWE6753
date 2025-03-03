extends Node

@export var start_level: PackedScene
@export var level_select_screen: PackedScene
@export var test_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_game_level = start_level.instantiate();
	add_child(start_game_level);
	$SceneManager.SetCurrentScene(start_game_level);
	start_game_level.start_game.connect(self._on_start_game.bind())
	start_game_level.continue_game.connect(self._on_continue_game.bind())
	start_game_level.exit_game.connect(self._on_exit_game.bind())



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game() -> void:
	_go_to_level_select()
	
func _on_continue_game() -> void:
	_go_to_level_select()
	
func _go_to_level_select() -> void:
	for n in get_children():
		remove_child(n)
		n.queue_free()
	var level_select = level_select_screen.instantiate();
	add_child(level_select)
	level_select.back_to_main.connect(self._go_to_main_menu.bind())
	#$SceneManager.SetCurrentScene(level_select)
	
func _on_exit_game() -> void:
	get_tree().quit()

func _go_to_main_menu() -> void:
	var start_game_level = start_level.instantiate();
	add_child(start_game_level);
	start_game_level.start_game.connect(self._on_start_game.bind())
	start_game_level.continue_game.connect(self._on_continue_game.bind())
	start_game_level.exit_game.connect(self._on_exit_game.bind())
