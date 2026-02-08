class_name Level
extends Node

const FLASHBANG_CURVE = preload("uid://c311oy0dclmrl")
const SLOT = preload("uid://bcn6c78r7cjih")
const SLOT_COUNT := 36

var game_locked := false
var slots: Array[SlottedItem] = []
var recycle_botton_particles_position: Vector2

@onready var value_points: Label = %ValuePoints
@onready var inventory_grid_container: GridContainer = $UI/Container/Margin/VBoxContainer/Game/Control/VBoxContainer/MainContainer/InventoryAndAbilities/InventoryGridContainer
@onready var round_timer: Timer = %RoundTimer
@onready var round_timer_pg: ProgressBar = %ValueRoundTimer
@onready var recycle_button: Button = %RecycleButton
@onready var shop_inventory: GridContainer = %ShopInventory
@onready var message: CanvasLayer = %Message
@onready var value_message: Label = %ValueMessage
@onready var value_rounds: Label = %ValueRounds
@onready var bang_particles: CPUParticles2D = %BangParticles
@onready var time_label: Label = %TimeLabel
@onready var shiny_flash: Control = %ShinyFlash


func _ready() -> void:
	shiny_flash.show()
	for child in inventory_grid_container.get_children():
		child.queue_free()
	for _i in SLOT_COUNT:
		var s: SlottedItem = SLOT.instantiate()
		inventory_grid_container.add_child(s)
		slots.append(s)
	shiny_flash.modulate.a = 0.0
	
	Events.score_changed.connect(_on_score_changed)
	Events.next_round.connect(_on_round_started)
	Events.game_complete.connect(_on_game_complete)
	Events.recycled_successfully.connect(_on_successfully_recycled)
	Events.items_combined.connect(_on_items_combined)
	
	round_timer_pg.max_value = Game.ROUND_TIME
	round_timer.timeout.connect(Game.round_complete)
	
	recycle_button.pressed.connect(Events.recycle.emit)
	recycle_botton_particles_position = bang_particles.global_position
	
	Game.level = self
	get_tree().paused = true



func _modulate_flash(x:float) -> void:
	assert(x >= 0.0 and x <= 1.0)
	var mapped = remap(x, 0.0, 1.0, 0.0, 420.0)
	shiny_flash.rotation_degrees = mapped
	shiny_flash.modulate.a = FLASHBANG_CURVE.sample(x)


func _on_successfully_recycled() -> void:
	bang_particles.global_position = recycle_botton_particles_position
	bang_particles.emitting = true
	round_timer.start(Game.ROUND_TIME)
	time_label.text = "Merge duplicates!"
	Sounds.recycle()
	create_tween().tween_method(_modulate_flash, 0.0, 1.0, 0.6)
	#shiny_flash.


func _on_items_combined(_item: SlottedItem.Items, _slot: SlottedItem) -> void:
	bang_particles.global_position = get_viewport().get_mouse_position()
	bang_particles.emitting = true
	Sounds.merge()


func _on_game_complete() -> void:
	clear_inventory()
	value_message.text = "In %d rounds you scored %d points. Go again?" % [Game.active_round.nr, Game.score]
	get_tree().paused = true
	game_locked = true
	await get_tree().create_timer(1.0).timeout
	game_locked = false


func _input(event: InputEvent) -> void:
	if not game_locked and (event.is_action("ui_accept") or event.is_action_pressed("click")) and get_tree().paused:
		get_tree().paused = false
		if not Game.game_started or Game.game_completed:
			Game.reset_game()
			Game.new_round()


func _on_round_started(active_round: Game.Round) -> void:
	value_rounds.text = "Round: %d - %s" % [active_round.nr, active_round.hint]
	fill_inventory(active_round.fill, active_round.trick)
	time_label.text = "Remove out of place!"


func _process(_delta: float) -> void:
	round_timer_pg.value = round_timer.time_left
	recycle_button.disabled = Game.recycled
	shop_inventory.get_children().map(func(n): n.modulate = Color.DARK_GREEN if Game.recycled else Color.WHITE)
	message.visible = get_tree().paused


func _on_score_changed(new_value: int) -> void:
	value_points.text = str(new_value)


func find_first_free_slot() -> SlottedItem:
	var ind: int = slots.find_custom(func(s:SlottedItem): return s.item == SlottedItem.Items.EMPTY)
	if ind != -1:
		return slots[ind]
	return null


func clear_inventory() -> void:
	slots.map(func(s: SlottedItem): 
		s.item = SlottedItem.Items.EMPTY
	)

func fill_inventory(fill_category: SlottedItem.ItemCategories, trick_category: SlottedItem.ItemCategories) -> void:
	slots.map(func(s: SlottedItem): 
		s.pick_random_item_from_category(fill_category)
		s.set_background(fill_category)
	)
	var count_out_of_place := 4
	var filling_slots = []
	while filling_slots.size() < count_out_of_place:
		var picked = slots.pick_random()
		if picked not in filling_slots:
			filling_slots.append(picked)
	for slot in filling_slots:
		slot.pick_random_item_from_category(trick_category)
