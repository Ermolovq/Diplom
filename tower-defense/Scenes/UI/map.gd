extends Control

var level_info: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()

func load_data():
	var saved_data = SaveFileHandler.load_saved_data()
	var current_level = saved_data["current_level"]
	for level in range(current_level):
		var level_path = "Level%d" % (level + 1)
		get_node("%s/LevelButton" % level_path).visible = true
		get_node("%s/Star1" % level_path).visible = true
		get_node("%s/Star2" % level_path).visible = true
		get_node("%s/Star3" % level_path).visible = true
		var stars = saved_data["levels"].get(str(level + 1), 0)
		for star in range(stars):
			get_node("%s/Star%d" % [level_path, star + 1]).texture = preload("res://Interface/star_full.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_settings_button_pressed() -> void:
	Global.previousScene = get_tree().current_scene.scene_file_path
	print(Global.previousScene)
	get_tree().change_scene_to_file("res://Scenes/UI/settings.tscn")

func open_level_info():
	var level_data = load("res://Resources/Levels_info/level%d.tres" % level_info)
	
	$"Level Info/Background/Name".text = level_data.name
	$"Level Info/Background/Desciption".text = level_data.description
	
	$"Level Info".visible = true
	for child in get_children():
		if child is TextureButton:
			child.disabled = true
		elif child is Node:
			for child1 in child.get_children():
				if child1 is TextureButton:
					child1.disabled = true

func _on_close_button_pressed() -> void:
	$"Level Info".visible = false
	for child in get_children():
		if child is TextureButton:
			child.disabled = false
		elif child is Node:
			for child1 in child.get_children():
				if child1 is TextureButton:
					child1.disabled = false

func _on_level_button_1_pressed() -> void:
	level_info = 1
	open_level_info()

func _on_level_button_2_pressed() -> void:
	level_info = 2
	open_level_info()

func _on_level_button_3_pressed() -> void:
	level_info = 3
	open_level_info()

func _on_level_button_4_pressed() -> void:
	level_info = 4
	open_level_info()

func _on_level_button_5_pressed() -> void:
	level_info = 5
	open_level_info()

func _on_level_button_6_pressed() -> void:
	level_info = 6
	open_level_info()

func _on_level_button_7_pressed() -> void:
	level_info = 7
	open_level_info()

func _on_level_button_8_pressed() -> void:
	level_info = 8
	open_level_info()

func _on_level_button_9_pressed() -> void:
	level_info = 9
	open_level_info()

func _on_level_button_10_pressed() -> void:
	level_info = 10
	open_level_info()


func _on_start_button_pressed() -> void:
	Global.current_level = level_info
	get_tree().change_scene_to_file("res://Scenes/UI/level.tscn")
