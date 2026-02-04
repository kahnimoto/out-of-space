class_name Level
extends Node


var slots: Array[SlottedItem] = []

@onready var shop: VBoxContainer = %Shop
@onready var waiting_for_shop: VBoxContainer = %WaitingForShop
@onready var time_until_shopper: ProgressBar = %TimeUntilShopper
@onready var order_line: HBoxContainer = %HBoxContainer
@onready var value_points: Label = %ValuePoints
@onready var ability_button_1: Button = %AbilityButton1
@onready var ability_button_2: Button = %AbilityButton2
@onready var shop_button_1: Button = %ShopButton1
@onready var shop_inventory: GridContainer = %ShopInventory
@onready var time_until_shop_closes: ProgressBar = %TimeUntilShopCloses


func _ready() -> void:
	assert(shop is VBoxContainer)
	shop.hide()
	waiting_for_shop.show()
	for child:SlottedItem in get_tree().get_nodes_in_group("inventory_slot"):
		slots.append(child)
	Game.level = self
	fill_start_inventory()
	Events.shop_closes.connect(func():
		shop.hide()
		waiting_for_shop.show()
	)
	Events.shop_opens.connect(func():
		order_line.get_node("SlotTexture").texture.region = SlottedItem.item_to_texture_rect(Game.orders[0].item)
		order_line.get_node("ValueTimes").text = str(Game.orders[0].amount)
		shop_button_1.disabled = false
		waiting_for_shop.hide()
		shop.show()
	)
	Events.score_changed.connect(_on_score_changed)
	ability_button_1.pressed.connect(_on_ability_button.bind(1))
	shop_button_1.pressed.connect(_on_shop_button_pressed.bind(1))


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _process(_delta: float) -> void:
	if Game.time_until_shop > 0.0:
		time_until_shopper.value = remap(Game.time_until_shop, 0.0, Game.TIME_BETWEEN_SHOPS, 0.0, 100.0)
	elif Game.time_left_to_shop > 0.0:
		time_until_shop_closes.value = remap(Game.time_left_to_shop, 0.0, Game.TIME_TO_SHOP, 0.0, 100.0)


func _on_score_changed(new_value: int) -> void:
	value_points.text = str(new_value)


func _on_ability_button(button_index: int) -> void:
	match button_index:
		1:
			print("generate loot!")
			ability_button_1.disabled = true
			Events.player_looted.emit()
			await get_tree().create_timer(Game.ABILITY_DELAY_TIMER).timeout
			ability_button_1.disabled = false
		_:
			push_warning("No such ability")

func _on_shop_button_pressed(button_index: int) -> void:
	match button_index:
		1:
			print("sell stuff!")
			shop_button_1.disabled = true
			Game.sell()
		_:
			push_warning("No such ability")



func find_first_free_slot() -> SlottedItem:
	var ind: int = slots.find_custom(func(s:SlottedItem): return s.item == SlottedItem.Items.EMPTY)
	if ind != -1:
		return slots[ind]
	return null


func fill_start_inventory() -> void:
	var count := Game.STARTING_ITEMS
	while count > 0:
		var slot = slots.pick_random()
		if slot.item == SlottedItem.Items.EMPTY:
			slot.debug_pick_random_item()
			count -= 1
	pass
