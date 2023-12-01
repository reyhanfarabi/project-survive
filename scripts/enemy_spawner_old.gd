extends Node2D


@export var _enemy_scene: PackedScene
@export var _enemy_textures: Array[CompressedTexture2D]
@export var _amount_per_spawn: int
@export var _spawn_delay: int

@onready var _player = get_parent().get_node("Player")

var _rng = RandomNumberGenerator.new()
var _tilemap_position
var _tilemap_size
var _tilemap_cell_size
var _can_spawn = true


# Called when the node enters the scene tree for the first time.
func _ready():
	_start()


func _start():
	_set_tilemap_data()
	$SpawnDelayTimer.wait_time = _spawn_delay


func _set_tilemap_data():
	var tilemap_rect = get_parent().get_node("TileMapGround").get_used_rect()
	_tilemap_position = tilemap_rect.position
	_tilemap_size = tilemap_rect.size
	_tilemap_cell_size = get_parent().get_node("TileMapGround").tile_set.tile_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _player:
		return
	#_spawn_enemies()


func _spawn_enemies():
	if not _can_spawn:
		return
	_can_spawn = false
	for i in range(_amount_per_spawn):
		var e = _enemy_scene.instantiate()
		e.texture = _enemy_textures[_rng.randf_range(0, _enemy_textures.size())]
		e.position = _get_random_location()
		add_child(e)
	$SpawnDelayTimer.start()


func _get_random_location():
	var left_pos = _tilemap_position.x * _tilemap_cell_size.x
	var right_pos = (_tilemap_position.x + _tilemap_size.x) * _tilemap_cell_size.x
	var top_pos = _tilemap_position.y * _tilemap_cell_size.y
	var bottom_pos = (_tilemap_position.y + _tilemap_size.y) * _tilemap_cell_size.y
	
	return Vector2(
		_rng.randf_range(left_pos, right_pos),
		_rng.randf_range(top_pos, bottom_pos)
	)


func _on_spawn_delay_timer_timeout():
	_can_spawn = true
