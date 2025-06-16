extends Node2D
class_name Towers

var enemy_array = []
var enemy
var ready_to_fire = true
var attack: int
var speed: int
var attack_type : int

func _ready() -> void:
	if self.name == "ArcherTower":
		attack = get_tree().current_scene.archer_tower_data.attack0
		speed = get_tree().current_scene.archer_tower_data.attack_speed0
		attack_type = get_tree().current_scene.archer_tower_data.attack_type
		self.get_node("Range/CollisionShape2D").get_shape().radius = 20 * get_tree().current_scene.archer_tower_data.radius0
	if self.name == "MagicTower":
		attack = get_tree().current_scene.magic_tower_data.attack0
		speed = get_tree().current_scene.magic_tower_data.attack_speed0
		attack_type = get_tree().current_scene.magic_tower_data.attack_type
		self.get_node("Range/CollisionShape2D").get_shape().radius = 20 * get_tree().current_scene.magic_tower_data.radius0
	if self.name == "CannonTower":
		attack = get_tree().current_scene.cannon_tower_data.attack0
		speed = get_tree().current_scene.cannon_tower_data.attack_speed0
		attack_type = get_tree().current_scene.cannon_tower_data.attack_type
		self.get_node("Range/CollisionShape2D").get_shape().radius = 20 * get_tree().current_scene.cannon_tower_data.radius0


func _physics_process(delta: float) -> void:
	if enemy_array.size() != 0:
		select_enemy()
		turn()
		if ready_to_fire:
			fire()
	else:
		enemy = null


func fire():
	ready_to_fire = false
	enemy.on_hit(attack, attack_type)
	await get_tree().create_timer(speed).timeout
	ready_to_fire = true


func turn():
	get_node("Sprite2D").look_at(enemy.position)


func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	var max_progress = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_progress)
	enemy = enemy_array[enemy_index]

func _on_range_body_entered(body: Node2D) -> void:
	enemy_array.append(body.get_parent())


func _on_range_body_exited(body: Node2D) -> void:
	enemy_array.erase(body.get_parent())
