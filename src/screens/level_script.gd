extends Node2D

signal level_win
signal level_lose
var player_goal
var level_finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_goal = 0
	level_finish = false;
	$Goal_P1.player_touch.connect(self._goal_touch.bind())
	$Goal_P2.player_touch.connect(self._goal_touch.bind())
	$Goal_P1.player_out.connect(self._goal_leave.bind())
	$Goal_P2.player_out.connect(self._goal_leave.bind())
	$Player.enemy_collision.connect(self._process_level_lose.bind())
	$Player2.enemy_collision.connect(self._process_level_lose.bind())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ( player_goal == 2 && level_finish == false):
		level_finish = true;
		level_win.emit()
	

func _goal_touch() -> void:
	player_goal += 1;

func _goal_leave() -> void:
	player_goal -= 1;
	
func _process_level_lose() -> void:
	level_lose.emit()
