extends Node2D


@export var _resource: Resource_Player
@export var _body: CharacterBody2D
@export var _animation_player: AnimationPlayer


func _physics_process(_delta):
	var input = Input.get_vector("left", "right", "top", "down")
	_handle_movement(input)
	_handle_animation(input)


func _handle_movement(input: Vector2):
	_body.velocity = _resource.move_speed * input
	_body.move_and_slide()


func _handle_animation(input: Vector2):
	if input != Vector2.ZERO:
		_animation_player.play("walking")
	else:
		_animation_player.play("idle")
