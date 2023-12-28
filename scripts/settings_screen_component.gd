extends CanvasLayer


signal trigger_back_button


func _ready():
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	trigger_back_button.emit()
