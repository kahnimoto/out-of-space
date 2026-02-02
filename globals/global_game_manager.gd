extends Node

var score := 10:
	set(v):
		if score != v:
			score = v
			Events.score_changed.emit(v)

var is_dragging := false
var dragging: SlottedItem.Items


func _ready() -> void:
	Events.new_item_requested.connect(_on_new_item_requested)
	Events.drag_started.connect(_on_drag_started)
	Events.drag_ended.connect(_on_drag_ended)
	Events.drag_aborted.connect(_on_drag_ended)


func _on_drag_started(item: SlottedItem.Items) -> void:
	is_dragging = true
	dragging = item


func _on_drag_ended() -> void:
	is_dragging = false


func _on_new_item_requested() -> void:
	score -= 1
