extends Node2D

signal level_win
signal level_lose
var player_goal
var level_finish
var lives
var level_code

var level_game_over = false;
var restarting_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var block_check = get_node_or_null("giantBlock")
	if(block_check):
		restarting_item = block_check.position
		print(restarting_item)
	$RestartTimer.stop()
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
		var bigBlock = get_node_or_null("giantBlock")
		var blockMarker = get_node_or_null("giantBlockMarker")
		if(bigBlock && blockMarker):
			bigBlock.global_transform.origin = blockMarker.position 
			bigBlock.rotation = 0.0
		player1._set_life_loss(true)
		player2._set_life_loss(true)
		player1.get_node("PlayerAnimation").play("explosion")
		player2.get_node("PlayerAnimation").play("explosion")
		player1.get_node("PlayerAnimation").set_speed_scale(10)
		player2.get_node("PlayerAnimation").set_speed_scale(10)
		$SFX/lose_a_life.play()
		player1.set_restart_position(player1Marker.position)
		player2.set_restart_position(player2Marker.position)
		lives = lives - 1;
		$RestartTimer.start();
	else:
		$SFX/whacked.play()

func _on_whacked_finished() -> void:
	level_lose.emit()


func _on_restart_timer_timeout() -> void:
	$Player._set_life_loss(false)
	$Player2._set_life_loss(false)
	$Player.get_node("PlayerAnimation").play("p1_idle")
	$Player2.get_node("PlayerAnimation").play("p2_idle")
