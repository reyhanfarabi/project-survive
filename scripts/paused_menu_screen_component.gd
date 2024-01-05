extends CanvasLayer
class_name PausedMenuScreenComponent


@onready var _continue_button: Button = $Control/VBoxContainer/MenuButtonContainer/ContinueGameButton

@export var _ui_layer: CanvasLayer
@export var _player_comp: PlayerComponent


func _ready() -> void:
	hide()
	

func _input(event) -> void:
	if (
		is_instance_valid(_player_comp) and 
		event.is_action_released("paused") and 
		not $SettingsScreenComponent.visible
	):
		visible = !visible
		_ui_layer.visible = !_ui_layer.visible
		get_tree().paused = !get_tree().paused


func _on_continue_game_button_pressed() -> void:
	hide()
	_ui_layer.visible = true
	get_tree().paused = false


func _on_restart_game_button_pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_quit_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen_component.tscn")


func _on_visibility_changed() -> void:
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		_continue_button.grab_focus()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_settings_button_pressed() -> void:
	$Control.hide()
	$SettingsScreenComponent.show()


func _on_settings_screen_component_trigger_back_button() -> void:
	$Control.show()
	$SettingsScreenComponent.hide()
