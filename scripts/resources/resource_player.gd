extends Resource

class_name Resource_Player

# base data
@export var max_health: int
@export var health: int
@export var attack_damage: int

# level data
@export var level: int
@export var level_base_multiplier: int
@export var current_level_max_experience: int
@export var current_level_experience: int

# level methods
func setup_level():
	current_level_experience = level * level_base_multiplier

func update_level(collected_exp: int):
	current_level_experience += collected_exp
	if current_level_experience >= current_level_max_experience:
		level += 1
		current_level_experience -= current_level_max_experience 
		current_level_max_experience = level * level_base_multiplier
