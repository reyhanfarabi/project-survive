extends HBoxContainer


@export var _player_resource: Resource_Player


func _ready():
	_config_health_bar()
	_config_health_digit()


func _config_health_bar():
	$HealthBar.max_value = _player_resource.max_health
	$HealthBar.value = _player_resource.health


func _config_health_digit():
	$CurrentHealth.set_text(str(_player_resource.health))
	$MaxHealth.set_text("/ " + str(_player_resource.max_health))


func _process(_delta):
	_update_health_bar()
	_update_health_digit()


func _update_health_bar():
	$HealthBar.value = _player_resource.health


func _update_health_digit():
	$CurrentHealth.set_text(str(_player_resource.health))
