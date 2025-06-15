extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists(SaveFileHandler.SAVE_GAME_PATH):
		$MarginContainer/VBoxContainer/Continue.disabled = false
		$MarginContainer/VBoxContainer/Continue.texture_normal = preload("res://Interface/button1.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	Global.previousScene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://Scenes/UI/settings.tscn")


func _on_new_game_pressed():
	$ConfirmNewGame.visible = true


func _on_cancel_button_pressed() -> void:
	$ConfirmNewGame.visible = false


func _on_start_new_game_button_pressed() -> void:
	SaveFileHandler.clear_saved_data()
	get_tree().change_scene_to_file("res://Scenes/UI/map.tscn")


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/map.tscn")
