extends Node

@export var start_level: PackedScene
@export var level_select_screen: PackedScene
@export var test_level: PackedScene
var level_to_load
var game_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_game_level = start_level.instantiate();
	$Levels.add_child(start_game_level);
	$SceneManager.SetCurrentScene(start_game_level);
	start_game_level.start_game.connect(self._on_start_game.bind())
	start_game_level.continue_game.connect(self._on_continue_game.bind())
	start_game_level.exit_game.connect(self._on_exit_game.bind())
	$menu_music.play();
	$level_select_music.stop();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game() -> void:
	$PlayerProgress.create_new_game_file();
	_go_to_level_select()
	
func _on_continue_game() -> void:
	if($PlayerProgress.check_has_save()):
		_go_to_level_select()
	
func _go_to_level_select() -> void:
	for n in $Levels.get_children():
		$Levels.remove_child(n)
		n.queue_free()
	var level_select = level_select_screen.instantiate();
	game_data = $PlayerProgress.load_game();
	print(game_data)
	level_select.game_data_set(game_data);
	$Levels.add_child(level_select)
	level_select.back_to_main.connect(self._go_to_main_menu.bind())
	level_select.select_level1_1.connect(self._go_to_level.bind(level_select.level1_1, "level1_1"));
	level_select.select_level1_2.connect(self._go_to_level.bind(level_select.level1_2, "level1_2"));
	level_select.select_level1_3.connect(self._go_to_level.bind(level_select.level1_3, "level1_3"));
	level_select.select_level1_4.connect(self._go_to_level.bind(level_select.level1_4, "level1_4"));
	level_select.select_level1_5.connect(self._go_to_level.bind(level_select.level1_5, "level1_5"));
	$SceneManager.SetCurrentScene(level_select)
	$menu_music.stop();
	$level_select_music.play();
	$level_music.stop();
	
func level_unlock(cur_level) -> void:
	var available_levels = game_data.get("available_levels");
	if(cur_level == "level1_1" and !available_levels.has("level1_2")):
		available_levels.append("level1_2");
	elif(cur_level == "level1_2" and !available_levels.has("level1_3")):
		available_levels.append("level1_3");
	elif(cur_level == "level1_3" and !available_levels.has("level1_4")):
		available_levels.append("level1_4");
	elif(cur_level == "level1_4" and !available_levels.has("level1_5")):
		available_levels.append("level1_5");
	$PlayerProgress.set_progress_add_level(available_levels);
	_go_to_level_select();	

func _on_exit_game() -> void:
	get_tree().quit()

func _go_to_main_menu() -> void:
	for n in $Levels.get_children():
		$Levels.remove_child(n)
		n.queue_free()
	var start_game_level = start_level.instantiate();
	$Levels.add_child(start_game_level);
	$SceneManager.SetCurrentScene(start_game_level)
	start_game_level.start_game.connect(self._on_start_game.bind())
	start_game_level.continue_game.connect(self._on_continue_game.bind())
	start_game_level.exit_game.connect(self._on_exit_game.bind())
	$menu_music.play();
	$level_select_music.stop();
	$level_music.stop();

func _go_to_level(level, level_code) -> void:
	for n in $Levels.get_children():
		$Levels.remove_child(n)
		n.queue_free()
	var newLevel = level.instantiate()
	$Levels.add_child(newLevel);
	$SceneManager.SetCurrentScene(newLevel)
	newLevel.level_win.connect(self.level_unlock.bind(level_code));
	newLevel.level_lose.connect(self._go_to_level.bind(level, level_code));
	$level_select_music.stop();
	$menu_music.stop();
	$level_music.play();
	


func ContinueGame() -> void:
	_go_to_level_select()
