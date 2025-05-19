extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_settings_button_pressed() -> void:
	Global.previousScene = get_tree().current_scene.scene_file_path
	print(Global.previousScene)
	get_tree().change_scene_to_file("res://Scenes/UI/settings.tscn")
