extends PathFollow2D
class_name Enemy

@export var stats: Resource
var speed: float
var hp: int
var gold: int
var magic_def: float
var phys_def: float


func _ready() -> void:
	assert(stats != null, "Enemy stats resource must be set")
	speed = stats.speed
	hp = stats.max_hp
	gold = stats.gold
	magic_def = stats.magic_def
	phys_def = stats.phys_def
	$Enemy/HPBar.max_value = hp
	$Enemy/HPBar.value = hp


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta):
	progress += speed * delta
	if progress_ratio >= 0.99:
		get_tree().current_scene.minus_hp(1)
		queue_free()


func on_hit(amount: int, attack_type: int):
	if attack_type == 0:
		hp -= amount * phys_def
	elif attack_type == 1:
		hp -= amount * magic_def
	$Enemy/HPBar.value = hp
	if hp <= 0:
		get_tree().current_scene.minus_enemies_amount()
		get_tree().current_scene.add_gold(gold)
		queue_free()
