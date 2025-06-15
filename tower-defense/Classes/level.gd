extends Node2D
class_name Level

var wave_data = []

var archer_tower_stats = load("res://Resources/Towers/ArcherTower.tres")
var magic_tower_stats = load("res://Resources/Towers/MagicTower.tres")
var cannon_tower_stats = load("res://Resources/Towers/CannonTower.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().add_gold(100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func place_tower(tower_place):
	var current_tower = get_parent().current_tower
	var tower_place_node = get_node("Towers/TowerPlace%d" % tower_place)
	if current_tower == 0:
		if int(get_tree().current_scene.get_node("PlayerStats/Gold").text) >= archer_tower_stats.cost0:
			var tower_scene = load("res://Scenes/Towers/ArcherTower.tscn").instantiate()
			tower_place_node.add_child(tower_scene)
			tower_scene.position = tower_place_node.get_size() / 2
			get_tree().current_scene.minus_gold(archer_tower_stats.cost0)
	if current_tower == 1:
		if int(get_tree().current_scene.get_node("PlayerStats/Gold").text) >= magic_tower_stats.cost0:
			var tower_scene = load("res://Scenes/Towers/MagicTower.tscn").instantiate()
			tower_place_node.add_child(tower_scene)
			tower_scene.position = tower_place_node.get_size() / 2
			get_tree().current_scene.minus_gold(magic_tower_stats.cost0)
	if current_tower == 2:
		if int(get_tree().current_scene.get_node("PlayerStats/Gold").text) >= cannon_tower_stats.cost0:
			var tower_scene = load("res://Scenes/Towers/CannonTower.tscn").instantiate()
			tower_place_node.add_child(tower_scene)
			tower_scene.position = tower_place_node.get_size() / 2
			get_tree().current_scene.minus_gold(cannon_tower_stats.cost0)
