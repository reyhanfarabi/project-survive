extends Resource_Entity

class_name Resource_Player_Base

# additional base data
@export var attack_cooldown: int = 1

# level data
@export var level: int = 1
@export var level_base_multiplier: int = 8
@export var current_level_max_experience: int = 0
@export var current_level_experience: int = 0
