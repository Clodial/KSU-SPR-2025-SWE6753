extends StaticBody2D

@export var textLabel: String
@export var tutorialWords: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clearText()

func writeText() -> void:
	var label = get_node_or_null(textLabel)
	print(label);
	if(label):
		label.text = tutorialWords

func clearText() -> void:
	var label = get_node_or_null(textLabel)
	if(label):
		label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
