extends CanvasLayer

@onready var value_points: Label = %ValuePoints


func _ready() -> void:
	Events.score_changed.connect(_on_score_changed)


func _on_score_changed(new_value: int) -> void:
	value_points.text = str(new_value)
