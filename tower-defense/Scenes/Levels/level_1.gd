extends Level


func _ready() -> void:
	wave_data = [["goblin", 1.0], ["goblin", 0.3], ["goblin", 0.3], ["goblin", 0.3], 
				["spider", 5.0], ["spider", 1.0], ["spider", 0.5], ["spider", 0.5], 
				["goblin", 5.0], ["goblin", 0.2], ["goblin", 0.2], ["goblin", 0.2], ["goblin", 0.2], ["goblin", 0.2], 
				["knight", 8.0], ["goblin", 0.2], ["goblin", 0.2], ["spider", 0.2], ["spider", 0.2],
				["knight", 8.0], ["knight", 8.0]]
	get_parent().add_gold(100)


func _on_tower_place_1_pressed() -> void:
	if $Towers/TowerPlace1.get_child_count() == 0:
		place_tower(1)


func _on_tower_place_2_pressed() -> void:
	if $Towers/TowerPlace2.get_child_count() == 0:
		place_tower(2)


func _on_tower_place_3_pressed() -> void:
	if $Towers/TowerPlace3.get_child_count() == 0:
		place_tower(3)


func _on_tower_place_4_pressed() -> void:
	if $Towers/TowerPlace4.get_child_count() == 0:
		place_tower(4)


func _on_tower_place_5_pressed() -> void:
	if $Towers/TowerPlace5.get_child_count() == 0:
		place_tower(5)


func _on_tower_place_6_pressed() -> void:
	if $Towers/TowerPlace6.get_child_count() == 0:
		place_tower(6)
