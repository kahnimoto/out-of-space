extends Node

const ROUND_TIME := 15.0

var score := 0:
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
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		round_complete()

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


var fill_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.LOOT
var trick_category: SlottedItem.ItemCategories = SlottedItem.ItemCategories.WEAPON

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
	fill_category = pick_random_category()
	trick_category = pick_random_category(fill_category)
	Events.next_round.emit(ROUND_TIME, fill_category, trick_category)
	

func round_complete() -> void:
	Events.drag_aborted.emit()
	# calulate winnings
	var correct := 0
	var wrong := 0
	
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
		os.item = SlottedItem.Items.EMPTY
	
	score = max(0, score + correct - wrong)
	#print("CORRECT: %d  -  WRONG: %d " % [correct, wrong])
	Events.round_complete.emit(correct, wrong)
	new_round()
