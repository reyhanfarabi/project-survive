extends StaticBody2D


@export var _resource: Resource_Enemy_Spawner
@export var _enemy_scene: PackedScene

@onready var _player: PlayerComponent = get_node("../../Player")
@onready var _enemy_container = get_node("../../EnemyContainer")

var _can_spawn: bool = true


func _ready():
	$SpawnGapTimer.wait_time = _resource.spawn_time_gap


func _process(_delta):
	if not _player:
		return
	_spawn_enemy()


func _spawn_enemy():
	if not _can_spawn:
		return
	_can_spawn = false
	var e = _enemy_scene.instantiate()
	e.set_resource(_resource.enemy_resource.duplicate())
	e.position = position
	_enemy_container.add_child(e)
	$SpawnGapTimer.start()


func _on_spawn_gap_timer_timeout():
	_can_spawn = true
