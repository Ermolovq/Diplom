extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer2/Sounds/soundsHSlider.value = Global.soundsVolume
	$MarginContainer/VBoxContainer2/Music/musicHSlider.value = Global.musicVolume
	$MarginContainer/VBoxContainer2/displayModeOptionButton.selected = Global.displayMode
	$MarginContainer/VBoxContainer2/resolutionOptionButton.selected = Global.resolution


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file(Global.previousScene)


func _on_save_pressed():
	Global.soundsVolume = $MarginContainer/VBoxContainer2/Sounds/soundsHSlider.value
	Global.musicVolume = $MarginContainer/VBoxContainer2/Music/musicHSlider.value
	Global.displayMode = $MarginContainer/VBoxContainer2/displayModeOptionButton.selected
	Global.resolution = $MarginContainer/VBoxContainer2/resolutionOptionButton.selected
	print(DisplayServer.window_get_mode())
	if Global.displayMode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif Global.displayMode == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Global.resolution == 0:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
	elif Global.resolution == 1:
		DisplayServer.window_set_size(Vector2i(1280, 720))
