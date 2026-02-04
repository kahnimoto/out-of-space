extends CanvasLayer


var current_requester: Object

@onready var tooltip_title: Label = %TooltipTitle
@onready var tooltip_container: Control = %TooltipContainer
@onready var drag_container: Control = %DragContainer
@onready var item_texture: TextureRect = %ItemTexture



func _ready() -> void:
	tooltip_container.hide()
	drag_container.hide()
	Events.tooltip_requested.connect(_on_tooltip_requested)
	Events.tooltip_released.connect(_on_tooltip_released)
	Events.drag_started.connect(_on_drag_started)
	Events.drag_ended.connect(_on_drag_ended)
	Events.drag_aborted.connect(_on_drag_ended)
	


func _process(_delta: float) -> void:
	if tooltip_container.visible:
		tooltip_container.position = get_viewport().get_mouse_position()
	if drag_container.visible:
		drag_container.position = get_viewport().get_mouse_position()


func _on_tooltip_requested(requester: Object, msg: String) -> void:
	tooltip_title.text = msg
	current_requester = requester
	tooltip_container.show()


func _on_tooltip_released(requester: Object) -> void:
	if requester == current_requester:
		requester = null
		tooltip_container.hide()


func _update_item(item: SlottedItem.Items) -> void:
	var start_coord = SlottedItem.REGION_LOCATION[item] * SlottedItem.SIZE as Vector2
	(item_texture.texture as AtlasTexture).region = Rect2(start_coord, Vector2(SlottedItem.SIZE, SlottedItem.SIZE))


func _on_drag_started(item: SlottedItem.Items, _source) -> void:
	#tooltip_title.text = SlottedItem.Items.keys()[item].capitalize()
	#tooltip_container.show()
	_update_item(item)
	drag_container.show()


func _on_drag_ended() -> void:
	drag_container.hide()
	#tooltip_container.hide()
