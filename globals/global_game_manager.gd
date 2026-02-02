extends Node

var score := 10:
	set(v):
		if score != v:
			score = v
			Events.score_changed.emit(v)

func _ready() -> void:
	Events.new_item_requested.connect(_on_new_item_requested)


func _on_new_item_requested() -> void:
	score -= 1
