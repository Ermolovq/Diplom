extends Control

var enemies_amount: int

var current_tower = 0
var level_scene_preload = load("res://Scenes/Levels/level%d.tscn" % Global.current_level)
var level_scene = level_scene_preload.instantiate()

var archer_tower_data = load("res://Resources/Towers/ArcherTower.tres")
var magic_tower_data = load("res://Resources/Towers/MagicTower.tres")
var cannon_tower_data = load("res://Resources/Towers/CannonTower.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TowerMenu/ArcherTowerPrice.text = str(archer_tower_data.cost0)
	$TowerMenu/MagicTowerPrice.text = str(magic_tower_data.cost0)
	$TowerMenu/CannonTowerPrice.text = str(cannon_tower_data.cost0)
	
	add_child(level_scene)
	start_next_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_gold(amount: int):
	var gold = int($PlayerStats/Gold.text)
	$PlayerStats/Gold.text = str(gold + amount)


func minus_gold(amount: int):
	var gold = int($PlayerStats/Gold.text)
	$PlayerStats/Gold.text = str(gold - amount)


func minus_hp(amount: int):
	var hp = int($PlayerStats/HP.text)
	$PlayerStats/HP.text = str(hp - amount)
	enemies_amount -= 1
	if int($PlayerStats/HP.text) <= 0:
		$MenuLose.visible = true
		disable_all_buttons(self)
		disable_all_buttons($TowerMenu)
		disable_all_buttons(level_scene)
		get_tree().paused = true
	enemies_check()

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.2).timeout
	spawn_enemies(wave_data)
	


func retrieve_wave_data():
	var wave_data = self.get_node("Level%d" % Global.current_level).wave_data
	enemies_amount = wave_data.size()
	return wave_data


func spawn_enemies(wave_data):
	for i in wave_data:
		var enemy_scene = load("res://Scenes/Enemies/" + i[0] + ".tscn")
		var new_enemy = enemy_scene.instantiate()
		level_scene.get_node("Path").add_child(new_enemy, true)
		await get_tree().create_timer(i[1]).timeout


func on_wave_cleared():
	var hp = int($PlayerStats/HP.text)
	var stars = 1
	if hp >= 18:
		stars = 3
	elif hp >= 15:
		stars = 2
	else:
		stars = 1
	SaveFileHandler.save(Global.current_level, stars)


func enemies_check():
	if enemies_amount == 0:
		on_wave_cleared()
		$MenuWin.visible = true
		disable_all_buttons(self)
		disable_all_buttons($TowerMenu)
		disable_all_buttons(level_scene)
		get_tree().paused = true


func minus_enemies_amount():
	enemies_amount -=1
	enemies_check()


func _on_exit_level_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/map.tscn")


func _on_menu_button_pressed() -> void:
	$Menu.visible = true
	disable_all_buttons(self)
	disable_all_buttons($TowerMenu)
	disable_all_buttons(level_scene)
	get_tree().paused = true


func _on_continue_pressed() -> void:
	$Menu.visible = false
	enable_all_buttons(self)
	enable_all_buttons($TowerMenu)
	enable_all_buttons(level_scene)
	get_tree().paused = false


func disable_all_buttons(node: Node):
	for child in node.get_children():
		if child is TextureButton:
			child.disabled = true


func enable_all_buttons(node: Node):
	for child in node.get_children():
		if child is TextureButton:
			child.disabled = false


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/level.tscn")


func _on_archer_tower_pressed() -> void:
	tower_menu_change(0)


func _on_magic_tower_pressed() -> void:
	tower_menu_change(1)


func _on_cannon_tower_pressed() -> void:
	tower_menu_change(2)

func tower_menu_change(new_current_tower):
	if current_tower == 0:
		$TowerMenu/ArcherTower.texture_normal = preload("res://Interface/button1.png")
	elif current_tower == 1:
		$TowerMenu/MagicTower.texture_normal = preload("res://Interface/button3.png")
	elif current_tower == 2:
		$TowerMenu/CannonTower.texture_normal = preload("res://Interface/button6.png")
		
	current_tower = new_current_tower
	
	if current_tower == 0:
		$TowerMenu/ArcherTower.texture_normal = preload("res://Interface/button4.png")
	elif current_tower == 1:
		$TowerMenu/MagicTower.texture_normal = preload("res://Interface/button4.png")
	elif current_tower == 2:
		$TowerMenu/CannonTower.texture_normal = preload("res://Interface/button4.png")
