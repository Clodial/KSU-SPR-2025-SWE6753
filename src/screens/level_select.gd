extends Node

signal back_to_main
signal select_level_1
@export var level_1: PackedScene
@export var level_1_text: String
@export var level_1_active: bool
signal select_level_2
@export var level_2: PackedScene
@export var level_2_text: String
@export var level_2_active: bool
signal select_level_3
@export var level_3: PackedScene
@export var level_3_text: String
@export var level_3_active: bool
signal select_level_4
@export var level_4: PackedScene
@export var level_4_text: String
@export var level_4_active: bool
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
	if(level_1_active):
		select_level_1.emit()
func _on_level_button_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_2_mouse_entered() -> void:
	$sub_level_label.text = level_2_text
func _on_level_button_2_pressed() -> void:
	if(level_2_active):
		select_level_2.emit()
func _on_level_button_2_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_3_mouse_entered() -> void:
	$sub_level_label.text = level_3_text
func _on_level_button_3_pressed() -> void:
	if(level_3_active):
		select_level_3.emit()
func _on_level_button_3_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_4_mouse_entered() -> void:
	$sub_level_label.text = level_4_text
func _on_level_button_4_pressed() -> void:
	if(level_4_active):
		select_level_4.emit()
func _on_level_button_4_mouse_exited() -> void:
	$sub_level_label.text = ""
	
func _on_main_menu_button_button_down() -> void:
	back_to_main.emit()
