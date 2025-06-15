extends Node

const SAVE_GAME_PATH = "user://savegame.save"

func save(completed_level: int, stars: int):
	var saved_data = {
		"current_level": 1,
		"levels": {}
	}
	
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		var loaded = file.get_var()
		if typeof(loaded) == TYPE_DICTIONARY:
			saved_data = loaded
		file.close()
	
	if completed_level + 1 > saved_data["current_level"]:
		saved_data["current_level"] = completed_level + 1
	
	var level_key = str(completed_level)
	var prev_stars = saved_data["levels"].get(level_key, 0)
	saved_data["levels"][level_key] = max(min(stars, 3), prev_stars)
	
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(saved_data)
	file.close()

func load_saved_data() -> Dictionary:
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		var saved_data = file.get_var()
		file.close()
		if typeof(saved_data) == TYPE_DICTIONARY:
			return saved_data
	return {
		"current_level": 1,
		"levels": {}
	}

func clear_saved_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var dir = DirAccess.open("user://")
		dir.remove("savegame.save")
