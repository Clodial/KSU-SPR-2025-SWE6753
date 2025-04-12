extends Node2D

signal level_win
signal level_lose
var player_goal
var level_finish
var lives
var level_code

var level_game_over = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lives = 3;
	player_goal = 0
	level_finish = false;
	$Goal_P1.player_touch.connect(self._goal_touch.bind())
	$Goal_P2.player_touch.connect(self._goal_touch.bind())
	$Goal_P1.player_out.connect(self._goal_leave.bind())
	$Goal_P2.player_out.connect(self._goal_leave.bind())
	$Player.enemy_collision.connect(
		self._process_level_lose.bind($Player, $Player2, $Player1Marker, $Player2Marker))
	$Player2.enemy_collision.connect(
		self._process_level_lose.bind($Player, $Player2, $Player1Marker, $Player2Marker))
	process_mode = Node.PROCESS_MODE_PAUSABLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(player_goal == 2 && level_finish == false):
		level_finish = true;
		level_win.emit()

func _goal_touch() -> void:
	$SFX/goal_hit.play()
	player_goal += 1;

func _goal_leave() -> void:
	$SFX/goal_leave.play()
	player_goal -= 1;
	
func _process_level_lose(player1, player2, player1Marker, player2Marker) -> void:
	if(lives > 1):
		$SFX/lose_a_life.play()
		lives = lives - 1;
		player1.position = player1Marker.position
		player2.position = player2Marker.position
	else:
		$SFX/whacked.play()

func _on_whacked_finished() -> void:
	level_lose.emit()
