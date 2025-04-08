extends Node

var level_data

signal back_to_main
signal select_level1_1
@export var level1_1: PackedScene
var level1_1_code = "level1_1"
@export var level1_1_text: String
@export var level1_1_active: bool
signal select_level1_2
@export var level1_2: PackedScene
var level1_2_code = "level1_2"
@export var level1_2_text: String
@export var level1_2_active: bool
signal select_level1_3
@export var level1_3: PackedScene
var level1_3_code = "level1_3"
@export var level1_3_text: String
@export var level1_3_active: bool
signal select_level1_4
@export var level1_4: PackedScene
var level1_4_code = "level1_4"
@export var level1_4_text: String
@export var level1_4_active: bool
signal select_level1_5
@export var level1_5: PackedScene
var level1_5_code = "level1_5"
@export var level1_5_text: String
@export var level1_5_active: bool
var available_levels = [
	level1_1_code,
	level1_2_code,
	level1_3_code,
	level1_4_code,
	level1_5_code
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$main_level_label.text = "Humble Beginnings"
	$sub_level_label.text = ""
	

func game_data_set(data) -> void:
	level_data = data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_level_button_mouse_entered() -> void:
	$sub_level_label.text = level1_1_text
func _on_level_button_button_down() -> void:
	if(level_data.get("available_levels").has(level1_1_code)):
		select_level1_1.emit()
func _on_level_button_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_2_mouse_entered() -> void:
	$sub_level_label.text = level1_2_text
func _on_level_button_2_pressed() -> void:
	if(level_data.get("available_levels").has(level1_2_code)):
		select_level1_2.emit()
func _on_level_button_2_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_3_mouse_entered() -> void:
	$sub_level_label.text = level1_3_text
func _on_level_button_3_pressed() -> void:
	if(level_data.get("available_levels").has(level1_3_code)):
		select_level1_3.emit()
func _on_level_button_3_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_4_mouse_entered() -> void:
	$sub_level_label.text = level1_4_text
func _on_level_button_4_pressed() -> void:
	if(level_data.get("available_levels").has(level1_4_code)):
		select_level1_4.emit()
func _on_level_button_4_mouse_exited() -> void:
	$sub_level_label.text = ""
	
func _on_level_button_5_pressed() -> void:
	if(level_data.get("available_levels").has(level1_5_code)):
		select_level1_5.emit()
func _on_level_button_5_mouse_entered() -> void:
	$sub_level_label.text = level1_5_text
func _on_level_button_5_mouse_exited() -> void:
	$sub_level_label.text = ""
	
func _on_main_menu_button_button_down() -> void:
	back_to_main.emit()
