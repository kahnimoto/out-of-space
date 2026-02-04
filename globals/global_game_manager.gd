extends Node

var score := 10:
	set(v):
		if score != v:
			score = v
			Events.score_changed.emit(v)

var is_dragging := false
var dragging: SlottedItem.Items
var dragging_from: Object
var level: Level


func _ready() -> void:
	Events.drag_started.connect(_on_drag_started)
	Events.drag_ended.connect(_on_drag_ended)
	Events.drag_aborted.connect(_on_drag_aborted)


func _input(event: InputEvent) -> void:
	if Game.is_dragging and event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
		Events.drag_aborted.emit()


func _process(_delta: float) -> void:
	pass


func _on_drag_started(item: SlottedItem.Items, source: Object) -> void:
	is_dragging = true
	dragging_from = source
	dragging = item


func _on_drag_ended() -> void:
	is_dragging = false


func _on_drag_aborted() -> void:
	is_dragging = false
	dragging_from.item = dragging
