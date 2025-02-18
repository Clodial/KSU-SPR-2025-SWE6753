extends Node2D


@onready var player1 = $Player
@onready var player2 = $Player2
var active_player = player1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player1 = $Player
	#player2 = $Player2
	#active_player = player1
	#player1.is_active = true
	#player2.is_active = false
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
