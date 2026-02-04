extends Node

const ABILITY_DELAY_TIMER := 1.0
const STARTING_ITEMS := 10
const TIME_BETWEEN_SHOPS := 5.0
const TIME_TO_SHOP := 10.0

var score := 10:
	set(v):
		if score != v:
			score = v
			Events.score_changed.emit(v)

var is_dragging := false
var dragging: SlottedItem.Items
var dragging_from: SlottedItem
var level: Level
var time_until_shop := TIME_BETWEEN_SHOPS
var time_left_to_shop := 0.0
var orders: Array[Order]

func _ready() -> void:
	Events.new_item_requested.connect(_on_new_item_requested)
	Events.drag_started.connect(_on_drag_started)
	Events.drag_ended.connect(_on_drag_ended)
	Events.drag_aborted.connect(_on_drag_aborted)
	Events.player_looted.connect(_on_player_looted)


func _input(event: InputEvent) -> void:
	if Game.is_dragging and event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
		Events.drag_aborted.emit()


func _process(delta: float) -> void:
	if time_until_shop > 0.0:
		time_until_shop -= delta
		if time_until_shop <= 0.0:
			time_left_to_shop = TIME_TO_SHOP
			_open_shop()
	if time_left_to_shop > 0.0:
		time_left_to_shop -= delta
		if time_left_to_shop <= 0.0:
			sell()


func _on_drag_started(item: SlottedItem.Items, source: SlottedItem) -> void:
	is_dragging = true
	dragging_from = source
	dragging = item


func _on_drag_ended() -> void:
	is_dragging = false


func _on_drag_aborted() -> void:
	is_dragging = false
	dragging_from.item = dragging


func _on_new_item_requested() -> void:
	score -= 1


func _on_player_looted() -> void:
	var free_slot: SlottedItem = level.find_first_free_slot()
	if free_slot:
		free_slot.debug_pick_random_item()
	else:
		print("No free slot")


func _open_shop() -> void:
	print("Shop opens")
	orders = []
	#for i in randi_range(1, 3):
	orders.append(Order.new(SlottedItem.pick_random_item(), randi_range(1, 5)))
	Events.shop_opens.emit()


func sell() -> void:
	var outgoing: Array[SlottedItem.Items] = []
	for slot in get_tree().get_nodes_in_group("shop_slot"):
		outgoing.append(slot.item)
		slot.item = SlottedItem.Items.EMPTY
	var earning := 0
	for i:SlottedItem.Items in outgoing:
		if i == orders[0].item and orders[0].fulfilled < orders[0].amount:
			earning += 10
			orders[0].fulfilled += 1
		elif i != 0:
			earning += 1
	score += earning
	print("Earned: %dp" % earning)
	time_until_shop = TIME_BETWEEN_SHOPS
	Events.shop_closes.emit()


class Order:
	var amount := 1
	var item: SlottedItem.Items
	var fulfilled := 0
	
	func _init(_item: SlottedItem.Items, count: int = 1) -> void:
		item = _item
		amount = count
