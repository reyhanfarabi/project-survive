extends HBoxContainer


@export var _player_resource: Resource_Player


func _ready():
	_set_level()
	_set_level_experience()


func _process(_delta):
	_set_level()
	_set_level_experience()


func _set_level():
	$LevelLabelContainer/LevelNumber.set_text(str(_player_resource.level))


func _set_level_experience():
	$LevelEXPBar.max_value = _player_resource.current_level_max_experience
	$LevelEXPBar.value = _player_resource.current_level_experience
