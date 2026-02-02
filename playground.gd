class_name Level
extends Node


var slots: Array[SlottedItem] = []


func _ready() -> void:
	for child:SlottedItem in get_tree().get_nodes_in_group("inventory_slot"):
		slots.append(child)
	Game.level = self


func find_first_free_slot() -> SlottedItem:
	var ind: int = slots.find_custom(func(s:SlottedItem): return s.item == SlottedItem.Items.EMPTY)
	if ind != -1:
		return slots[ind]
	return null



func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
