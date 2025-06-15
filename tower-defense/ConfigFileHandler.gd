extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("video", "fullscreen", false)
		config.set_value("video", "resolution", 1)
		
		config.set_value("audio", "sounds", 0.5)
		config.set_value("audio", "music", 0.5)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
	use_settings()

func use_settings():
	var video_settings = ConfigFileHandler.load_video_settings()
	if video_settings.fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if video_settings.resolution == 0:
		DisplayServer.window_set_size(Vector2i(1920,1080))
	elif video_settings.resolution == 1:
		DisplayServer.window_set_size(Vector2i(1280,720))
	
	var audio_settings = ConfigFileHandler.load_audio_settings()

func save_video_settings(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings

func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
