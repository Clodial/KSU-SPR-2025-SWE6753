extends Node

signal back_to_main
signal select_level_1
@export var level_1: PackedScene
@export var level_1_text: String
@export var level_1_active: bool
signal select_level_2
signal select_level_3
signal select_level_4
signal select_level_5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$sub_level_label.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_button_mouse_entered() -> void:
	$sub_level_label.text = level_1_text


func _on_level_button_button_down() -> void:
	select_level_1.emit()


func _on_level_button_mouse_exited() -> void:
	$sub_level_label.text = ""


func _on_main_menu_button_button_down() -> void:
	back_to_main.emit()
