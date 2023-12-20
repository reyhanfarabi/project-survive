extends CanvasLayer
class_name GameOverScreenComponent


@onready var _restart_button: Button = $Control/VBoxContainer/MenuButtonContainer/RestartGameButton


func _ready():
	hide()


func _on_restart_game_button_pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_quit_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen_component.tscn")


func _on_visibility_changed():
	if visible:
		_restart_button.grab_focus()
