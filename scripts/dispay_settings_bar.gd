extends TabBar


@onready var _display_mode_options: OptionButton = $MarginContainer/VBoxContainer/ModeOptions/OptionButton

var _display_mode_dict: Dictionary = {
	0: DisplayServer.WINDOW_MODE_FULLSCREEN,
	1: DisplayServer.WINDOW_MODE_WINDOWED
}


func _ready() -> void:
	_set_current_display_mode()


func _set_current_display_mode() -> void:
	_display_mode_options.selected = _display_mode_dict.find_key(DisplayServer.window_get_mode())


func _set_display_mode(index: int) -> void:
	if DisplayServer.window_get_mode() != _display_mode_dict[index]:
		DisplayServer.window_set_mode(_display_mode_dict[index])


func _on_option_button_item_selected(index) -> void:
	_set_display_mode(index)
