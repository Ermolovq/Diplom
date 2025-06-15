extends Control

@onready var fullscreen_checkbox = $MarginContainer/VBoxContainer2/fullscreenCheckbox
@onready var resolution_option_button = $MarginContainer/VBoxContainer2/resolutionOptionButton
@onready var sounds_slider = $MarginContainer/VBoxContainer2/Sounds/soundsHSlider
@onready var music_slider = $MarginContainer/VBoxContainer2/Music/musicHSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	var video_settings = ConfigFileHandler.load_video_settings()
	fullscreen_checkbox.button_pressed = video_settings.fullscreen
	resolution_option_button.selected = video_settings.resolution
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	sounds_slider.value = audio_settings.sounds * 100
	music_slider.value = audio_settings.music * 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file(Global.previousScene)


func _on_save_pressed():
	ConfigFileHandler.save_video_settings("fullscreen", fullscreen_checkbox.button_pressed)
	ConfigFileHandler.save_video_settings("resolution", resolution_option_button.selected)
	
	ConfigFileHandler.save_audio_settings("sounds", sounds_slider.value / 100)
	ConfigFileHandler.save_audio_settings("music", music_slider.value / 100)
	
	ConfigFileHandler.use_settings()
