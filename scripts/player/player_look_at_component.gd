extends Node2D
class_name PlayerLookAtComponent


@export var _sprite: Sprite2D
var _look_at: Vector2: set = _set_look_at, get = get_look_at
var _last_look_at: Vector2
var _is_joystick = false


func _input(event) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		_is_joystick = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		_is_joystick = true


func _set_look_at(value: Vector2):
	_look_at = value


func get_look_at() -> Vector2:
	return _look_at


func _process(_delta) -> void:
	_handle_sprite_facing(_get_lookat_vector())
	_last_look_at = get_look_at()
	_set_look_at(_get_lookat_vector())


func _handle_sprite_facing(input: Vector2) -> void:
	if input.x > 0:
		_sprite.set_flip_h(false)
		
	elif input.x < 0:
		_sprite.set_flip_h(true)


func _get_mouse_lookat_vector() -> Vector2:
	var center_viewport_position = get_viewport_rect().size / 2
	var mouse_position = get_viewport().get_mouse_position()
	return (mouse_position - center_viewport_position).normalized()


func _get_joystick_lookat_vector() -> Vector2:
	var input = Input.get_vector("look_left", "look_right", "look_top", "look_down")
	if input == Vector2.ZERO:
		return _last_look_at
	else:
		return input


func _get_lookat_vector() -> Vector2:
	if _is_joystick:
		return _get_joystick_lookat_vector()
	else:
		return _get_mouse_lookat_vector()
