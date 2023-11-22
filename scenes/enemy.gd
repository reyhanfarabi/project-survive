extends Area2D


@export var entity: Resource_Entity
@export var speed: int = 50

@onready var player = get_parent().get_node("Player")

var direction: Vector2


func _ready():
	pass # Replace with function body.


func _process(delta):
	direction = Vector2(player.position - position).normalized()
	handle_movement(delta)
	handle_facing()


func handle_movement(delta):
	position += direction * speed * delta


func handle_facing():
	if direction.x > 0:
		$Sprite2D.flip_h = false
	elif direction.x < 0:
		$Sprite2D.flip_h = true
