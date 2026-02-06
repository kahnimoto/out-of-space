extends Node

const MAX_ROUNDS := 5
const ROUND_TIME := 10.0

var score := 0:
	set(v):
		if score != v:
			score = v
			Events.score_changed.emit(v)
var is_dragging := false
var dragging: SlottedItem.Items
var dragging_from: Object
var level: Level
var fill_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.LOOT
var trick_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.WEAPON
var recycled := false
var correct := 0
var wrong := 0
var scored := false
var rounds := 1
var game_completed := false
var game_started := false


func reset_game() -> void:
	game_started = false
	game_completed = false
	rounds = 1
	wrong = 0
	correct = 0
	score = 0
	scored = false
	recycled = false
	dragging = SlottedItem.Items.EMPTY
	is_dragging = false


func _ready() -> void:
	Events.drag_started.connect(_on_drag_started)
	Events.drag_ended.connect(_on_drag_ended)
	Events.drag_aborted.connect(_on_drag_aborted)
	Events.items_combined.connect(_on_items_combined)
	Events.recycle.connect(_on_recycle)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


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


func _on_items_combined(_item: SlottedItem.Items, _slot: SlottedItem) -> void:
	score += 4


func _on_recycle() -> void:
	_recycle() 
	if correct == 4 and wrong == 0:
		Events.recycled_successfully.emit()
		recycled = true
		scored = true
		score += 4
		for os in get_tree().get_nodes_in_group("outgoing_slot"):
			os.item = SlottedItem.Items.EMPTY
	else:
		Sounds.error()


func _recycle() -> void:
	correct = 0
	wrong = 0
	for os in get_tree().get_nodes_in_group("outgoing_slot"):
		if os.item != SlottedItem.Items.EMPTY:
			match trick_category:
				SlottedItem.ItemCategories.WEAPON:
					if os.item in SlottedItem.WEAPONS:
						correct += 1
					else:
						wrong += 1
				SlottedItem.ItemCategories.ARMOUR:
					if os.item in SlottedItem.ARMOURS:
						correct += 1
					else:
						wrong += 1
				SlottedItem.ItemCategories.FOOD:
					if os.item in SlottedItem.FOODS:
						correct += 1
					else:
						wrong += 1
				SlottedItem.ItemCategories.LOOT:
					if os.item in SlottedItem.LOOTS:
						correct += 1
					else:
						wrong += 1
	

func pick_random_category(avoiding: SlottedItem.ItemCategories = SlottedItem.ItemCategories.NONE) -> SlottedItem.ItemCategories:
	var a = [
		SlottedItem.ItemCategories.WEAPON,
		SlottedItem.ItemCategories.ARMOUR,
		SlottedItem.ItemCategories.LOOT,
		SlottedItem.ItemCategories.FOOD,
	]
	if avoiding != SlottedItem.ItemCategories.NONE:
		a.erase(avoiding)
	return a.pick_random()


func new_round() -> void:
	game_started = true
	recycled = false
	scored = false
	fill_category = pick_random_category()
	trick_category = pick_random_category(fill_category)
	Sounds.refresh_inventory()
	Events.next_round.emit(ROUND_TIME, fill_category, trick_category)


func round_complete() -> void:
	Events.drag_aborted.emit()
	if not recycled:
		_recycle()
		if correct < 4:
			Sounds.error()
	if not scored:
		score = max(0, score + correct - wrong)
		for os in get_tree().get_nodes_in_group("outgoing_slot"):
			os.item = SlottedItem.Items.EMPTY
	Events.round_complete.emit(correct, wrong)
	if rounds < MAX_ROUNDS:
		rounds += 1
		new_round()
	else:
		game_completed = true
		Events.game_complete.emit()
