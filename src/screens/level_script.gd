extends Node2D

signal level_win
signal level_lose
var player_goal
var level_finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_goal = 0
	level_finish = false;
	$Goal_P1.player_touch.connect()
	$Goal_P2.player_touch.connect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ( player_goal == 2 && level_finish == false):
		level_finish = true;
		level_win.emit()
