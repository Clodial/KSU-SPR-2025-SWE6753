extends Node2D

signal level_win
signal level_lose
signal level_is_lost
var player_goal
var level_finish
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_goal = 0
	level_finish = false;
	
	$Player.connect("lost_life", Callable(self, "lose_life"))
	#$Player2.connect("lost_life", Callable(self, "lose_life"))
	$Goal_P1.player_touch.connect(self._goal_touch.bind())
	$Goal_P2.player_touch.connect(self._goal_touch.bind())
	$Goal_P1.player_out.connect(self._goal_leave.bind())
	$Goal_P2.player_out.connect(self._goal_leave.bind())
	$Player.enemy_collision.connect(self._process_level_lose.bind())
	$Player2.enemy_collision.connect(self._process_level_lose.bind())
	process_mode = Node.PROCESS_MODE_PAUSABLE
	

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

func lose_life():
	print("Before losing life: " + str(lives))
	if lives > 0:
		lives -= 1
		print("Lives Remaining: " + str(lives))
	elif lives == 0:
		level_is_lost.emit()


func _on_player_lost_life() -> void:
	print("Player lost a life!")
	lose_life()

#func _on_player_2_lost_life() -> void:
	#lose_life() # Replace with function body.
