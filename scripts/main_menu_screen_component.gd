extends CanvasLayer


@onready var _start_game_button: Button = $Control/VBoxContainer/MenuButtonContainer/StartGameButton
@onready var _version_number_label: Label = $Control/VersionNumberLabel


func _ready() -> void:
	_start_game_button.grab_focus()
	_set_project_version()


func _set_project_version() -> void:
	print(_get_project_version())
	_version_number_label.text = "v" + _get_project_version()


func _get_project_version() -> String:
	var export_config = ConfigFile.new()
	var export_config_path = "res://export_presets.cfg"
	var config_error = export_config.load(export_config_path)
	return export_config.get_value("preset.0.options", "application/product_version", "dynamic product version")


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()
