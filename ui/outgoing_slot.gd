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
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_pressed():
			if item and item != SlottedItem.Items.EMPTY and not Game.is_dragging:
				Events.drag_started.emit(item, self)
				item = SlottedItem.Items.EMPTY
				
				Sounds.grab()
			elif Game.is_dragging:
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
		elif mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.is_pressed():
			if item and item !=  SlottedItem.Items.EMPTY:
				var out_slots = get_tree().get_nodes_in_group("inventory_slot")
				var index_of_empty: int = out_slots.find_custom(func(s): return s.item == SlottedItem.Items.EMPTY)
				if index_of_empty == -1:
					return
				var free_outgoing_slot: SlottedItem = out_slots[index_of_empty]
				free_outgoing_slot.item = item
				item = SlottedItem.Items.EMPTY
				Sounds.grab()
