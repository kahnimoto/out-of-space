extends CanvasLayer


var current_requester: Object

@onready var tooltip_title: Label = %TooltipTitle
@onready var container: Control = $Container



func _ready() -> void:
	container.hide()
	Events.tooltip_requested.connect(_on_tooltip_requested)
	Events.tooltip_released.connect(_on_tooltip_released)


func _process(_delta: float) -> void:
	if container.visible:
		container.position = get_viewport().get_mouse_position()


func _on_tooltip_requested(requester: Object, msg: String) -> void:
	tooltip_title.text = msg
	current_requester = requester
	container.show()


func _on_tooltip_released(requester: Object) -> void:
	if requester == current_requester:
		requester = null
		container.hide()
