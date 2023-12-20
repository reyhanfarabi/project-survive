extends Resource_Entity

class_name Resource_Player

# additional base data
@export var attack_cooldown: int = 1

# level data
@export var level: int
@export var level_base_multiplier: int
@export var current_level_max_experience: int
@export var current_level_experience: int


func init(base_resource: Resource_Player_Base):
	max_health = base_resource.max_health
	health = base_resource.max_health
	attack_damage = base_resource.attack_damage
	move_speed = base_resource.move_speed
	attack_cooldown = base_resource.attack_cooldown
	
	level = base_resource.level
	level_base_multiplier = base_resource.level_base_multiplier
	current_level_experience = base_resource.current_level_experience
	current_level_max_experience = level * level_base_multiplier
	

func update_level(collected_exp: int):
	current_level_experience += collected_exp
	if current_level_experience >= current_level_max_experience:
		level += 1
		current_level_experience -= current_level_max_experience 
		current_level_max_experience = level * level_base_multiplier
