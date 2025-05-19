extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	Global.previousScene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://Scenes/UI/settings.tscn")


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/map.tscn")
