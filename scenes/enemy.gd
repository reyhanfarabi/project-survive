extends Area2D


@export var entity: Resource_Entity
@export var speed: int = 50
@export var attack_cooldown: int = 2
@export var target_distance_padding: int = 1

@onready var player = get_parent().get_node("Player")

var direction: Vector2
var can_attack: bool = true


func _ready():
	start()


func start():
	$AttackTimer.wait_time = attack_cooldown


func _process(delta):
	direction = Vector2(player.position - position).normalized()
	handle_movement(delta)
	handle_facing()
	handle_attack_to_player()


func handle_movement(delta):
	if (position.distance_to(player.position) > target_distance_padding):
		position += direction * speed * delta


func handle_facing():
	if direction.x > 0:
		$Sprite2D.flip_h = false
	elif direction.x < 0:
		$Sprite2D.flip_h = true


func handle_attack_to_player():
	if not can_attack or not overlaps_body(player):
		return
	can_attack = false
	$AttackTimer.start()
	player.entity.health -= entity.attack_damage
	print(player.entity.health)


func _on_attack_timer_timeout():
	can_attack = true
