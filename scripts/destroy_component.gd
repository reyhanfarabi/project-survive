extends Node2D
class_name DestroyComponent


signal trigger_side_effect


func handle_destroy(current_health: int) -> void:
	if current_health <= 0:
		trigger_side_effect.emit()
		get_parent().queue_free()
