extends Node2D


@export var _resources: Array[ResourceEnemySpawner]

var _rng = RandomNumberGenerator.new()
var _tilemap_position
var _tilemap_size
var _tilemap_cell_size
const _TILEMAP_SPAWN_SIZE_PADDING := 1     # this will add padding to spawn area so it will not spawn close to map edge
const _TILEMAP_SPAWN_BOTTOM_PADDING := 2   # this will prevent spawn outside of playable area on the bottom map
var _can_spawn := true


func _ready():
	_set_tilemap_data()
	_spawn_enemy_sources()
	_sort_nodes()


func _spawn_enemy_sources():
	for spawner in _resources:
		for i in spawner.spawner_max_amount:
			var es := spawner.scene.instantiate()
			es.position = _get_random_location()
			add_child(es)


func _sort_nodes():
	var nodes := get_children()
	
	nodes.sort_custom(
		func (a: Node, b: Node): return a.position.y < b.position.y
	)
	
	for node in get_children():
		remove_child(node)
	
	for node in nodes:
		add_child(node)


func _set_tilemap_data():
	var tilemap_rect = get_parent().get_node("TileMapGround").get_used_rect()
	_tilemap_position = tilemap_rect.position
	_tilemap_size = tilemap_rect.size
	_tilemap_cell_size = get_parent().get_node("TileMapGround").tile_set.tile_size


func _get_random_location():
	var left_pos = (_tilemap_position.x + _TILEMAP_SPAWN_BOTTOM_PADDING) * _tilemap_cell_size.x
	var right_pos = (_tilemap_position.x + _tilemap_size.x - _TILEMAP_SPAWN_BOTTOM_PADDING) * _tilemap_cell_size.x
	var top_pos = (_tilemap_position.y + _TILEMAP_SPAWN_SIZE_PADDING) * _tilemap_cell_size.y
	var bottom_pos = (_tilemap_position.y + _tilemap_size.y - _TILEMAP_SPAWN_BOTTOM_PADDING - _TILEMAP_SPAWN_SIZE_PADDING) * _tilemap_cell_size.y
	
	return Vector2(
		_rng.randf_range(left_pos, right_pos),
		_rng.randf_range(top_pos, bottom_pos)
	)
