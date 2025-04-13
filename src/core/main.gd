extends Node

@export var start_level: PackedScene
@export var level_select_screen: PackedScene
@export var test_level: PackedScene
var level_to_load
var game_data
var game_quit = false

var song_position = 0.0
var active_song

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
	$SliderMenu/SliderHUD.hide();
	active_song = $level_music

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(game_quit):
		get_tree().quit()

func _on_start_game() -> void:
	$SFX/select.play()
	$PlayerProgress.create_new_game_file();
	_go_to_level_select()
	
func _on_continue_game() -> void:
	if($PlayerProgress.check_has_save()):
		$SFX/select.play()
		_go_to_level_select()
	
func _go_to_level_select() -> void:
	for n in $Levels.get_children():
		$Levels.remove_child(n)
		n.queue_free()
	var level_select = level_select_screen.instantiate();
	game_data = $PlayerProgress.load_game();
	
	level_select.game_data_set(game_data);
	level_select.set_button_data(game_data, 1)
	$Levels.add_child(level_select)
	level_select.back_to_main.connect(self._go_to_main_menu.bind())
	level_select.select_level1_1.connect(self._go_to_level.bind(level_select.level1_1, "level1_1"));
	level_select.select_level1_2.connect(self._go_to_level.bind(level_select.level1_2, "level1_2"));
	level_select.select_level1_3.connect(self._go_to_level.bind(level_select.level1_3, "level1_3"));
	level_select.select_level1_4.connect(self._go_to_level.bind(level_select.level1_4, "level1_4"));
	level_select.select_level1_5.connect(self._go_to_level.bind(level_select.level1_5, "level1_5"));
	level_select.select_level2_1.connect(self._go_to_level.bind(level_select.level2_1, "level2_1"));
	level_select.select_level2_2.connect(self._go_to_level.bind(level_select.level2_2, "level2_2"));
	level_select.select_level2_3.connect(self._go_to_level.bind(level_select.level2_3, "level2_3"));
	level_select.select_level2_4.connect(self._go_to_level.bind(level_select.level2_4, "level2_4"));
	level_select.select_level2_5.connect(self._go_to_level.bind(level_select.level2_5, "level2_5"));
	level_select.select_level3_1.connect(self._go_to_level.bind(level_select.level3_1, "level3_1"));
	level_select.select_level3_2.connect(self._go_to_level.bind(level_select.level3_2, "level3_2"));
	level_select.select_level3_3.connect(self._go_to_level.bind(level_select.level3_3, "level3_3"));
	level_select.select_level3_4.connect(self._go_to_level.bind(level_select.level3_4, "level3_4"));
	level_select.select_level3_5.connect(self._go_to_level.bind(level_select.level3_5, "level3_5"));
	$SceneManager.SetCurrentScene(level_select)
	$menu_music.stop();
	$level_select_music.play();
	song_position = active_song.get_playback_position();
	active_song.stop();

func level_appender(next_level):
	var available_levels = game_data.get("available_levels")
	if(!available_levels.has(next_level)):
		available_levels.append(next_level)
		$PlayerProgress.set_progress_add_level(available_levels)
		return next_level
	else:
		return null
	

func level_unlock(cur_level) -> void:
	var finished: bool = false
	var next_level = null
	
	if(cur_level == "level1_1"):
		next_level = level_appender("level1_2")
	elif(cur_level == "level1_2" ):
		next_level = level_appender("level1_3");
	elif(cur_level == "level1_3" ):
		next_level = level_appender("level1_4")
	elif(cur_level == "level1_4"):
		next_level = level_appender("level1_5")
	elif(cur_level == "level1_5"):
		next_level = level_appender("level2_1")
	elif(cur_level == "level2_1"):
		next_level = level_appender("level2_2")
	elif(cur_level == "level2_2"):
		next_level = level_appender("level2_3")
	elif(cur_level == "level2_3"):
		next_level = level_appender("level2_4")
	elif(cur_level == "level2_4"):
		next_level = level_appender("level2_5")
	elif(cur_level == "level2_5"):
		next_level = level_appender("level3_1")
	elif(cur_level == "level3_1"):
		next_level = level_appender("level3_2")
	elif(cur_level == "level3_2"):
		next_level = level_appender("level3_3")
	elif(cur_level == "level3_3"):
		next_level = level_appender("level3_4")
	elif(cur_level == "level3_4"):
		next_level = level_appender("level3_5")
	else:
		finished = true
	
	if(finished || next_level == null):
		_go_to_level_select();
	else:
		_go_to_level($SceneManager.GetScene(next_level), next_level)

func _on_exit_game() -> void:
	$SFX/exit.play()

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
	song_position = active_song.get_playback_position();
	$level_select_music.stop();
	active_song.stop();

func _go_to_level(level, level_code) -> void:
	for n in $Levels.get_children():
		$Levels.remove_child(n)
		n.queue_free()
	var newLevel = level.instantiate()
	$Levels.add_child(newLevel);
	$SceneManager.SetCurrentScene(newLevel)
	newLevel.level_win.connect(self.level_unlock.bind(level_code));
	newLevel.level_lose.connect(self._go_to_level_select.bind());
	$level_select_music.stop();
	$menu_music.stop();
	if(!$level_music.playing):
		$level_music.play(song_position);

func pause_level_music() -> void:
	song_position = active_song.get_playback_position()
	active_song.stop()

func play_level_music() -> void:
	active_song.play(song_position)

func ContinueGame() -> void:
	_go_to_level_select()

func _on_exit_finished() -> void:
	game_quit = true
