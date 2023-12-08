extends Area2D
class_name CollectDropsComponent


signal trigger_drop_effect(drop: Area2D)


func _process(_delta) -> void:
	_collect_drops()


func _collect_drops() -> void:
	for area in get_overlapping_areas():
		if area.is_in_group("drops"):
			trigger_drop_effect.emit(area)
			area.destroy()
