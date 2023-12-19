extends CanvasLayer
class_name PausedMenuScreenComponent


@onready var _continue_button: Button = $Control/VBoxContainer/MenuButtonContainer/ContinueGameButton

@export var _ui_layer: CanvasLayer


func _ready() -> void:
	hide()
	

func _input(event) -> void:
	if event.is_action_released("paused"):
		visible = !visible
		_ui_layer.visible = !_ui_layer.visible
		get_tree().paused = !get_tree().paused


func _on_continue_game_button_pressed() -> void:
	hide()
	_ui_layer.visible = true
	get_tree().paused = false


func _on_restart_game_button_pressed() -> void:
	# TODO: add pause logic
	pass


func _on_quit_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen_component.tscn")


func _on_visibility_changed() -> void:
	if visible:
		_continue_button.grab_focus()
