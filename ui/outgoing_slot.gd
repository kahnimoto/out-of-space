@tool
class_name OutgoingSlot
extends Control

@export var item: SlottedItem.Items = SlottedItem.Items.EMPTY:
	set(v):
		if item != v:
			item = v
			if is_node_ready():
				_update_item()

var item_name: String:
	get:
		return SlottedItem.Items.keys()[item].capitalize()
		
@onready var slot_item_texture: TextureRect = $SlotItemTexture


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _update_item() -> void:
	if slot_item_texture.texture is AtlasTexture:
		slot_item_texture.texture.region = SlottedItem.item_to_texture_rect(item)


func _on_mouse_entered() -> void:
	if not item or item == SlottedItem.Items.EMPTY or Game.is_dragging:
		return
	Events.tooltip_requested.emit(self, item_name)


func _on_mouse_exited() -> void:
	Events.tooltip_released.emit(self)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	if event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.is_pressed() and item and item != SlottedItem.Items.EMPTY and not Game.is_dragging:
				Events.drag_started.emit(item, self)
				item = SlottedItem.Items.EMPTY
				
				Sounds.grab()
			elif mouse_event.is_pressed() and Game.is_dragging:
				if item:
					var old_item = item
					item = Game.dragging
					Events.drag_ended.emit()
					Events.drag_started.emit(old_item, self)
					Sounds.grab()
				else:
					Sounds.put_down()
					item = Game.dragging
					Events.drag_ended.emit()
