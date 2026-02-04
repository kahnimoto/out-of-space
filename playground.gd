class_name Level
extends Node

const SLOT = preload("uid://bcn6c78r7cjih")
const SLOT_COUNT := 36

var slots: Array[SlottedItem] = []

@onready var value_points: Label = %ValuePoints
@onready var inventory_grid_container: GridContainer = $UI/Container/Margin/VBoxContainer/Game/Control/VBoxContainer/MainContainer/InventoryAndAbilities/InventoryGridContainer


func _ready() -> void:
	#for child:SlottedItem in get_tree().get_nodes_in_group("inventory_slot"):
	for child in inventory_grid_container.get_children():
		child.queue_free()
	for _i in SLOT_COUNT:
		var s: SlottedItem = SLOT.instantiate()
		inventory_grid_container.add_child(s)
		slots.append(s)
	Game.level = self
	fill_start_inventory()
	Events.score_changed.connect(_on_score_changed)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		fill_start_inventory()


func _process(_delta: float) -> void:
	pass

func _on_score_changed(new_value: int) -> void:
	value_points.text = str(new_value)



func find_first_free_slot() -> SlottedItem:
	var ind: int = slots.find_custom(func(s:SlottedItem): return s.item == SlottedItem.Items.EMPTY)
	if ind != -1:
		return slots[ind]
	return null


func fill_start_inventory() -> void:
	var random_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.WEAPON
	var other_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.ARMOUR
	slots.map(func(s: SlottedItem): 
		s.pick_random_item_from_category(random_category)
		print(s.item)
	)
	var count_out_of_place := 4
	for i in count_out_of_place:
		var slot = slots.pick_random()
		slot.pick_random_item_from_category(other_category)
