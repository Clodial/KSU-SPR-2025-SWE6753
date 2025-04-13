extends Node

var level_data = {
	"available_levels": [
		"level1-1"
	]
}

signal back_to_main
signal select_level1_1
signal select_level1_2
signal select_level1_3
signal select_level1_4
signal select_level1_5

signal select_level2_1
signal select_level2_2
signal select_level2_3
signal select_level2_4
signal select_level2_5

signal select_level3_1
signal select_level3_2
signal select_level3_3
signal select_level3_4
signal select_level3_5

var level_section = 1

@export var level1_1: PackedScene
@export var level1_1_text: String
@export var level1_1_active: bool
@export var level1_2: PackedScene
@export var level1_2_text: String
@export var level1_2_active: bool
@export var level1_3: PackedScene
@export var level1_3_text: String
@export var level1_3_active: bool
@export var level1_4: PackedScene
@export var level1_4_text: String
@export var level1_4_active: bool
@export var level1_5: PackedScene
@export var level1_5_text: String
@export var level1_5_active: bool

@export var level2_1: PackedScene
@export var level2_1_text: String
@export var level2_1_active: bool
@export var level2_2: PackedScene
@export var level2_2_text: String
@export var level2_2_active: bool
@export var level2_3: PackedScene
@export var level2_3_text: String
@export var level2_3_active: bool
@export var level2_4: PackedScene
@export var level2_4_text: String
@export var level2_4_active: bool
@export var level2_5: PackedScene
@export var level2_5_text: String
@export var level2_5_active: bool

@export var level3_1: PackedScene
@export var level3_1_text: String
@export var level3_1_active: bool
@export var level3_2: PackedScene
@export var level3_2_text: String
@export var level3_2_active: bool
@export var level3_3: PackedScene
@export var level3_3_text: String
@export var level3_3_active: bool
@export var level3_4: PackedScene
@export var level3_4_text: String
@export var level3_4_active: bool
@export var level3_5: PackedScene
@export var level3_5_text: String
@export var level3_5_active: bool

var level1_1_code = "level1_1"
var level1_2_code = "level1_2"
var level1_3_code = "level1_3"
var level1_4_code = "level1_4"
var level1_5_code = "level1_5"

var level2_1_code = "level2_1"
var level2_2_code = "level2_2"
var level2_3_code = "level2_3"
var level2_4_code = "level2_4"
var level2_5_code = "level2_5"

var level3_1_code = "level3_1"
var level3_2_code = "level3_2"
var level3_3_code = "level3_3"
var level3_4_code = "level3_4"
var level3_5_code = "level3_5"

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

func set_button_state(data, level_code, node_location):
	if(!data.get("available_levels").has(level_code)):
		get_node(node_location).disabled = true
	else:
		get_node(node_location).disabled = false

func set_button_data(data, section) -> void:
	if section == 1:
		$main_level_label.text = "Humble Beginnings"
		set_button_state(data, level1_1_code, "level_picker/level1/levelButton")
		set_button_state(data, level1_2_code, "level_picker/level2/levelButton2")
		set_button_state(data, level1_3_code, "level_picker/level3/levelButton3")
		set_button_state(data, level1_4_code, "level_picker/level4/levelButton4")
		set_button_state(data, level1_5_code, "level_picker/level5/levelButton5")
	elif section == 2:
		$main_level_label.text = "Individual Contributor"
		set_button_state(data, level2_1_code, "level_picker/level1/levelButton")
		set_button_state(data, level2_2_code, "level_picker/level2/levelButton2")
		set_button_state(data, level2_3_code, "level_picker/level3/levelButton3")
		set_button_state(data, level2_4_code, "level_picker/level4/levelButton4")
		set_button_state(data, level2_5_code, "level_picker/level5/levelButton5")
	elif section == 3:
		$main_level_label.text = "The Corner Office"
		set_button_state(data, level3_1_code, "level_picker/level1/levelButton")
		set_button_state(data, level3_2_code, "level_picker/level2/levelButton2")
		set_button_state(data, level3_3_code, "level_picker/level3/levelButton3")
		set_button_state(data, level3_4_code, "level_picker/level4/levelButton4")
		set_button_state(data, level3_5_code, "level_picker/level5/levelButton5")

func _on_level_button_mouse_entered() -> void:
	if(level_section == 1):
		$sub_level_label.text = level1_1_text
	elif(level_section == 2):
		$sub_level_label.text = level2_1_text
	else:
		$sub_level_label.text = level3_1_text
func _on_level_button_button_down() -> void:
	if(level_section == 1 && level_data.get("available_levels").has(level1_1_code)):
		select_level1_1.emit()
	if(level_section == 2 && level_data.get("available_levels").has(level2_1_code)):
		select_level2_1.emit()
	if(level_section == 3 && level_data.get("available_levels").has(level3_1_code)):
		select_level3_1.emit()
func _on_level_button_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_2_mouse_entered() -> void:
	if(level_section == 1):
		$sub_level_label.text = level1_2_text
	elif(level_section == 2):
		$sub_level_label.text = level2_2_text
	else:
		$sub_level_label.text = level3_2_text
func _on_level_button_2_pressed() -> void:
	if(level_section == 1 && level_data.get("available_levels").has(level1_2_code)):
		select_level1_2.emit()
	if(level_section == 2 && level_data.get("available_levels").has(level2_2_code)):
		select_level2_2.emit()
	if(level_section == 3 && level_data.get("available_levels").has(level3_2_code)):
		select_level3_2.emit()
func _on_level_button_2_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_3_mouse_entered() -> void:
	if(level_section == 1):
		$sub_level_label.text = level1_3_text
	elif(level_section == 2):
		$sub_level_label.text = level2_3_text
	else:
		$sub_level_label.text = level3_3_text
func _on_level_button_3_pressed() -> void:
	if(level_section == 1 && level_data.get("available_levels").has(level1_3_code)):
		select_level1_3.emit()
	if(level_section == 2 && level_data.get("available_levels").has(level2_3_code)):
		select_level2_3.emit()
	if(level_section == 3 && level_data.get("available_levels").has(level3_3_code)):
		select_level3_3.emit()
func _on_level_button_3_mouse_exited() -> void:
	$sub_level_label.text = ""

func _on_level_button_4_mouse_entered() -> void:
	if(level_section == 1):
		$sub_level_label.text = level1_4_text
	elif(level_section == 2):
		$sub_level_label.text = level2_4_text
	else:
		$sub_level_label.text = level3_4_text
func _on_level_button_4_pressed() -> void:
	if(level_section == 1 && level_data.get("available_levels").has(level1_4_code)):
		select_level1_4.emit()
	if(level_section == 2 && level_data.get("available_levels").has(level2_4_code)):
		select_level2_4.emit()
	if(level_section == 3 && level_data.get("available_levels").has(level3_4_code)):
		select_level3_4.emit()
func _on_level_button_4_mouse_exited() -> void:
	$sub_level_label.text = ""
	
func _on_level_button_5_pressed() -> void:
	if(level_section == 1 && level_data.get("available_levels").has(level1_5_code)):
		select_level1_5.emit()
	if(level_section == 2 && level_data.get("available_levels").has(level2_5_code)):
		select_level2_5.emit()
	if(level_section == 3 && level_data.get("available_levels").has(level3_5_code)):
		select_level3_5.emit()
func _on_level_button_5_mouse_entered() -> void:
	if(level_section == 1):
		$sub_level_label.text = level1_5_text
	elif(level_section == 2):
		$sub_level_label.text = level2_5_text
	else:
		$sub_level_label.text = level3_5_text
func _on_level_button_5_mouse_exited() -> void:
	$sub_level_label.text = ""
	
func _on_main_menu_button_button_down() -> void:
	back_to_main.emit()


func _on_left_button_pressed() -> void:
	if level_section > 1:
		level_section = level_section - 1
	if level_section == 1:
		set_button_data(level_data, 1)
	elif level_section == 2:
		set_button_data(level_data, 2)
	else:
		set_button_data(level_data, 3)


func _on_right_button_pressed() -> void:
	if level_section < 3:
		level_section = level_section + 1
	if level_section == 1:
		set_button_data(level_data, 1)
	elif level_section == 2:
		set_button_data(level_data, 2)
	else:
		set_button_data(level_data, 3)
