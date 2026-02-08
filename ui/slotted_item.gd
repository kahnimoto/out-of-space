@tool
class_name SlottedItem
extends Control


enum Items {
	EMPTY,
	SKULL_AND_BONES, GREEN_FIRE_BALL, #EYE_CLOSED, SPEECH_BUBBLE, EVIL_SMILE, SPARKLES, HEARTS, SLEEP, LIGHTNING, FLAMING_SKULL, WATER_DROPS,
	#HEART, LUNGS, STOMACH, BRAIN, BICEP,
	#UP_ARROW, DOWN_ARROW, UP_RIGHT_ARROW, DOWN_RIGHT_ARROW, CURVED_UP_ARROW, CURVED_DOWN_ARROW, REFRESH,
	#BLOODIED_KNIFE, GREEN_SLASH, SWORD_CROSS, SKULL_ARROW, ARROW_VOLLEY, HEAL_RADIUS, BANDAGED_ARM, SHIELD_UP, BLUE_PENDANT, THORN_CROWN, WHITE_MASK, RED_FIST, YELLOW_SLASH, ICE_STEP, PURPLE_SILHOUETTE, SUN,
	#SQUARE_SPEACH_BUBBLES, SPEECH_BUBBLES,
	CAMPFIRE, TENT, # ANVIL, PICKAXE_MINING, AXE_LOGGING, BOOK_RESEARCH, RUN_FAST,
	WOODEN_SWORD, DAGGER, SHORT_SWORD, IRON_SWORD, BROAD_SWORD, SCIMITAR, RAPIER, ESTOC, SAI, DUAL_DAGGERS, AXE, BATTLE_AXE, MACE, WOODEN_CLUB, WHIP, FIST_GLOVE, 
	WOODEN_SHIELD, IRON_SHIELD, KITE_SHIELD, BOW, CROSSBOW, SLINGSHOT, BOOMERANG, GNARLED_STAFF, BLUE_STAFF, RED_STAFF, GREEN_STAFF, YELLOW_STAFF,
	LEATHER_CAP, IRON_HELMET, LEATHER_HELMET, GREAT_HELM, IRON_CHESTPLATE, STEEL_CHESTPLATE, LEATHER_TUNIC, HEAVY_PLATE, BLUE_TUNIC, GREEN_TUNIC, BLACK_TROUSERS, BROWN_TROUSERS, BOXERS, BLUE_DRESS, PURPLE_CLOAK, BELT,
	LEATHER_GLOVES, GAUNTLETS_IRON, LEATHER_BOOTS, SHOES_LEATHER, RING_GOLD, RING_BLUE_GEM, NECKLACE_GOLD, NECKLACE_RED, NECKLACE_SILVER, BACKPACK,
	RED_POTION, BLUE_POTION, GREEN_POTION, YELLOW_POTION, 
	#POTION_RED_M, POTION_BLUE_M, POTION_GREEN_M, POTION_YELLOW_M, 
	#POTION_RED_L, POTION_BLUE_L, POTION_GREEN_L, POTION_YELLOW_L, 
	FLASK_RED, FLASK_YELLOW, FLASK_PINK, BANDAGE_ROLL,
	POUCH, HATCHET, PICKAXE, SHOVEL, HAMMER, POLE_AXE, HOE, SPYGLASS, MAGNIFYING_GLASS, LANTERN, TORCH, CANDLE, BOMB, ROPE, BEAR_TRAP, HOURGLASS,
	RUNE, HAND_MIRROR, SHACKLES, HARP, VIOLIN, OCARINA, FLUTE, PAN_FLUTE, HUNTING_HORN, KEY_IRON, KEY_RING, CHEST_WOOD, MORTAR_PESTLE, LEAF_GREEN, LEAF_AUTUMN, LEAF_FERN,
	MUSHROOM_BROWN, FLOWER_BUD, LOG_BRANCH, FLOWER_POT_1, FLOWER_POT_2, FLOWER_POT_3, MONEY_BAG, GOLD_COIN, COPPER_STACK, SILVER_STACK, GOLD_STACK, GOLD_SACK, 
	# HANDED_COINS, PAYNG_COINS, 
	CRYSTAL_SHARDS, RUBY_GEM,
	BOOK_BLUE, BOOK_RED, BOOK_GREEN, BOOK_YELLOW, BOOK_BLACK, BOOK_BROWN, BLUE_SPELLBOOK, RED_SPELLBOOK, BOOK_READING, ENVELOPE, SCROLL_TIED, PAPER_DOCUMENT, TREASURE_MAP, DICE, PLAYING_CARD_ACE, WINE_BOTTLE,
	APPLE, BANANA, PEAR, LEMON, STRAWBERRY, GRAPES, CARROT, CORN, GARLIC, TOMATO, EGGPLANT, CHILI_PEPPER, MUSHROOM_WHITE, BREAD_LOAF, BAGUETTE, ROAST_CHICKEN,
	CHICKEN_LEG, STEAK_RAW, HAM_BONE, MEAT_RIB, FISH_FILLET, EGGS_BASKET, EGG_SINGLE, CHEESE_WEDGE, WATER_BOTTLE, HONEY_POT, FLOUR_BAG, SPICE_BAG, CANDY, CAKE_SLICE, COFFEE_MUG,
	FISHING_ROD, FISHING_HOOK, EARTHWORM, FISH_BLUE, FISH_BROWN, EEL, FISH_YELLOW, CLOWNFISH, JELLYFISH, OCTOPUS, TURTLE, FISH_SKELETON, SHELL, CHEST_TREASURE,
	LOG_WOOD, STONE_BLOCK, ORE_BLUE, GOLD_BAR, DIAMOND, COTTON_BOLL, YARN_BALL, FABRIC_ROLL, LEATHER_HIDE, MONSTER_TOOTH, FEATHER,
	ORB_RED, ORB_BLUE, ORB_GREEN, ORB_YELLOW, ORB_PURPLE, ORB_BLACK
}
enum ItemCategories {
	WEAPON,
	ARMOUR,
	FOOD,
	LOOT,
	NONE
}

const CategoryToColor: Dictionary[ItemCategories, Color] = {
	ItemCategories.WEAPON: Color.AQUAMARINE,
	ItemCategories.ARMOUR: Color.DARK_SEA_GREEN,
	ItemCategories.FOOD: Color.LIGHT_CORAL,
	ItemCategories.LOOT: Color.SANDY_BROWN
}
const WEAPONS: Array[Items] = [
	Items.WOODEN_SWORD, Items.DAGGER, Items.SHORT_SWORD, Items.IRON_SWORD, Items.BROAD_SWORD, Items.SCIMITAR, Items.RAPIER, Items.ESTOC, Items.SAI, Items.DUAL_DAGGERS, Items.AXE, Items.BATTLE_AXE, Items.MACE, Items.WOODEN_CLUB, Items.WHIP,
	Items.BOW, Items.CROSSBOW, Items.SLINGSHOT, Items.BOOMERANG, Items.GNARLED_STAFF, Items.BLUE_STAFF, Items.RED_STAFF, Items.GREEN_STAFF, Items.YELLOW_STAFF,  Items.BLUE_SPELLBOOK, Items.RED_SPELLBOOK,
]

const ARMOURS: Array[Items] = [
	Items.WOODEN_SHIELD, Items.IRON_SHIELD, Items.KITE_SHIELD,
	Items.LEATHER_CAP, Items.IRON_HELMET, Items.LEATHER_HELMET, Items.GREAT_HELM, Items.IRON_CHESTPLATE, Items.STEEL_CHESTPLATE, Items.LEATHER_TUNIC, Items.HEAVY_PLATE, Items.BLUE_TUNIC, Items.GREEN_TUNIC, Items.BLACK_TROUSERS, Items.BROWN_TROUSERS, Items.BOXERS, Items.BLUE_DRESS, Items.PURPLE_CLOAK, Items.BELT,
	Items.LEATHER_GLOVES, Items.GAUNTLETS_IRON, Items.LEATHER_BOOTS, Items.SHOES_LEATHER,
	
]

const FOODS: Array[Items] = [
	Items.APPLE, Items.BANANA, Items.PEAR, Items.LEMON, Items.STRAWBERRY, Items.GRAPES, Items.CARROT, Items.CORN, Items.GARLIC, Items.EGGPLANT, Items.CHILI_PEPPER, Items.MUSHROOM_WHITE, Items.BREAD_LOAF, Items.BAGUETTE, Items.ROAST_CHICKEN,
	Items.CHICKEN_LEG, Items.STEAK_RAW, Items.HAM_BONE, Items.MEAT_RIB, Items.EGGS_BASKET, Items.EGG_SINGLE, Items.CHEESE_WEDGE, Items.WATER_BOTTLE, Items.HONEY_POT, Items.CANDY, Items.CAKE_SLICE,
	Items.FISH_BROWN, Items.EEL, Items.FISH_YELLOW
]

const LOOTS: Array[Items] = [
	Items.GOLD_COIN, Items.COPPER_STACK, Items.SILVER_STACK, Items.GOLD_STACK, Items.GOLD_SACK, Items.CRYSTAL_SHARDS, Items.RUBY_GEM, Items.POUCH, 
	Items.BOOK_BLUE, Items.BOOK_RED, Items.BOOK_GREEN, Items.BOOK_YELLOW, Items.BOOK_BLACK, Items.BOOK_BROWN, Items.BOOK_READING, Items.ENVELOPE, Items.SCROLL_TIED, Items.PAPER_DOCUMENT, Items.TREASURE_MAP, Items.DICE, Items.PLAYING_CARD_ACE, 
	Items.RED_POTION, Items.BLUE_POTION, Items.GREEN_POTION, Items.YELLOW_POTION, Items.DIAMOND, Items.GOLD_BAR, Items.MONSTER_TOOTH, Items.LEATHER_HIDE, 
]

const REGION_LOCATION: Dictionary[Items, Vector2i] = {
	Items.EMPTY: Vector2i(11, 0),
	Items.SKULL_AND_BONES: Vector2i(0, 0), Items.GREEN_FIRE_BALL: Vector2i(1, 0),
	#Items.EYE_CLOSED: Vector2i(2, 0), Items.SPEECH_BUBBLE: Vector2i(3, 0), Items.EVIL_SMILE: Vector2i(4, 0), Items.SPARKLES: Vector2i(5, 0), Items.HEARTS: Vector2i(6, 0), Items.SLEEP: Vector2i(7, 0), Items.LIGHTNING: Vector2i(8, 0), Items.FLAMING_SKULL: Vector2i(9, 0), Items.WATER_DROPS: Vector2i(10, 0),
	#Items.HEART: Vector2i(0, 1), Items.LUNGS: Vector2i(1, 1), Items.STOMACH: Vector2i(2, 1), Items.BRAIN: Vector2i(3, 1), Items.BICEP: Vector2i(4, 1),
	#Items.UP_ARROW: Vector2i(0, 2), Items.DOWN_ARROW: Vector2i(1, 2), Items.UP_RIGHT_ARROW: Vector2i(2, 2), Items.DOWN_RIGHT_ARROW: Vector2i(3, 2), Items.CURVED_UP_ARROW: Vector2i(4, 2), Items.CURVED_DOWN_ARROW: Vector2i(5, 2), Items.REFRESH: Vector2i(6, 2),
	#Items.BLOODIED_KNIFE: Vector2i(0, 3), Items.GREEN_SLASH: Vector2i(1, 3), Items.SWORD_CROSS: Vector2i(2, 3), Items.SKULL_ARROW: Vector2i(3, 3), Items.ARROW_VOLLEY: Vector2i(4, 3), Items.HEAL_RADIUS: Vector2i(5, 3), Items.BANDAGED_ARM: Vector2i(6, 3),  Items.SHIELD_UP: Vector2i(7, 3), Items.BLUE_PENDANT: Vector2i(8, 3), Items.THORN_CROWN: Vector2i(9, 3), Items.WHITE_MASK: Vector2i(10, 3), Items.RED_FIST: Vector2i(11, 3), Items.YELLOW_SLASH: Vector2i(12, 3), Items.ICE_STEP: Vector2i(13, 3), Items.PURPLE_SILHOUETTE: Vector2i(14, 3), Items.SUN: Vector2i(15, 3),
	#Items.SQUARE_SPEACH_BUBBLES: Vector2i(0, 4), Items.SPEECH_BUBBLES: Vector2i(1, 4),
	Items.CAMPFIRE: Vector2i(2, 4), Items.TENT: Vector2i(3, 4), # Items.ANVIL: Vector2i(4, 4), Items.PICKAXE_MINING: Vector2i(5, 4), Items.AXE_LOGGING: Vector2i(6, 4), Items.BOOK_RESEARCH: Vector2i(7, 4), Items.RUN_FAST: Vector2i(8, 4),
	Items.WOODEN_SWORD: Vector2i(0, 5), Items.DAGGER: Vector2i(1, 5), Items.SHORT_SWORD: Vector2i(2, 5), Items.IRON_SWORD: Vector2i(3, 5), Items.BROAD_SWORD: Vector2i(4, 5), Items.SCIMITAR: Vector2i(5, 5), Items.RAPIER: Vector2i(6, 5), Items.ESTOC: Vector2i(7, 5), Items.SAI: Vector2i(8, 5), Items.DUAL_DAGGERS: Vector2i(9, 5),
	Items.AXE: Vector2i(10, 5), Items.BATTLE_AXE: Vector2i(11, 5), Items.MACE: Vector2i(12, 5), Items.WOODEN_CLUB: Vector2i(13, 5), Items.WHIP: Vector2i(14, 5), Items.FIST_GLOVE: Vector2i(15, 5),
	Items.WOODEN_SHIELD: Vector2i(0, 6), Items.IRON_SHIELD: Vector2i(1, 6), Items.KITE_SHIELD: Vector2i(2, 6), Items.BOW: Vector2i(3, 6), Items.CROSSBOW: Vector2i(4, 6), Items.SLINGSHOT: Vector2i(5, 6), Items.BOOMERANG: Vector2i(6, 6), Items.GNARLED_STAFF: Vector2i(7, 6), Items.BLUE_STAFF: Vector2i(8, 6), Items.RED_STAFF: Vector2i(9, 6), Items.GREEN_STAFF: Vector2i(10, 6), Items.YELLOW_STAFF: Vector2i(11, 6),
	Items.LEATHER_CAP: Vector2i(0, 7), Items.IRON_HELMET: Vector2i(1, 7), Items.LEATHER_HELMET: Vector2i(2, 7), Items.GREAT_HELM: Vector2i(3, 7), Items.IRON_CHESTPLATE: Vector2i(4, 7), Items.STEEL_CHESTPLATE: Vector2i(5, 7), Items.LEATHER_TUNIC: Vector2i(6, 7), Items.HEAVY_PLATE: Vector2i(7, 7), Items.BLUE_TUNIC: Vector2i(8, 7), Items.GREEN_TUNIC: Vector2i(9, 7), Items.BLACK_TROUSERS: Vector2i(10, 7), Items.BROWN_TROUSERS: Vector2i(11, 7), Items.BOXERS: Vector2i(12, 7), Items.BLUE_DRESS: Vector2i(13, 7), Items.PURPLE_CLOAK: Vector2i(14, 7), Items.BELT: Vector2i(15, 7),
	Items.LEATHER_GLOVES: Vector2i(0, 8), Items.GAUNTLETS_IRON: Vector2i(1, 8), Items.LEATHER_BOOTS: Vector2i(2, 8), Items.SHOES_LEATHER: Vector2i(3, 8), Items.RING_GOLD: Vector2i(4, 8), Items.RING_BLUE_GEM: Vector2i(5, 8), Items.NECKLACE_GOLD: Vector2i(6, 8), Items.NECKLACE_RED: Vector2i(7, 8), Items.NECKLACE_SILVER: Vector2i(8, 8), Items.BACKPACK: Vector2i(9, 8),
	Items.RED_POTION: Vector2i(0, 9), Items.BLUE_POTION: Vector2i(1, 9), Items.GREEN_POTION: Vector2i(2, 9), Items.YELLOW_POTION: Vector2i(3, 9), 
	#Items.POTION_RED_M: Vector2i(4, 9), Items.POTION_BLUE_M: Vector2i(5, 9), Items.POTION_GREEN_M: Vector2i(6, 9), Items.POTION_YELLOW_M: Vector2i(7, 9), Items.POTION_RED_L: Vector2i(8, 9), Items.POTION_BLUE_L: Vector2i(9, 9), Items.POTION_GREEN_L: Vector2i(10, 9), Items.POTION_YELLOW_L: Vector2i(11, 9),
	Items.FLASK_RED: Vector2i(12, 9), Items.FLASK_YELLOW: Vector2i(13, 9), Items.FLASK_PINK: Vector2i(14, 9), Items.BANDAGE_ROLL: Vector2i(15, 9),
	Items.POUCH: Vector2i(0, 10), Items.HATCHET: Vector2i(1, 10), Items.PICKAXE: Vector2i(2, 10), Items.SHOVEL: Vector2i(3, 10), Items.HAMMER: Vector2i(4, 10), Items.POLE_AXE: Vector2i(5, 10), Items.HOE: Vector2i(6, 10), Items.SPYGLASS: Vector2i(7, 10), Items.MAGNIFYING_GLASS: Vector2i(8, 10), Items.LANTERN: Vector2i(9, 10), Items.TORCH: Vector2i(10, 10), Items.CANDLE: Vector2i(11, 10), Items.BOMB: Vector2i(12, 10), Items.ROPE: Vector2i(13, 10), Items.BEAR_TRAP: Vector2i(14, 10), Items.HOURGLASS: Vector2i(15, 10),
	Items.RUNE: Vector2i(0, 11), Items.HAND_MIRROR: Vector2i(1, 11), Items.SHACKLES: Vector2i(2, 11), Items.HARP: Vector2i(3, 11), Items.VIOLIN: Vector2i(4, 11), Items.OCARINA: Vector2i(5, 11), Items.FLUTE: Vector2i(6, 11), Items.PAN_FLUTE: Vector2i(7, 11), Items.HUNTING_HORN: Vector2i(8, 11), Items.KEY_IRON: Vector2i(9, 11), Items.KEY_RING: Vector2i(10, 11), Items.CHEST_WOOD: Vector2i(11, 11), Items.MORTAR_PESTLE: Vector2i(12, 11), Items.LEAF_GREEN: Vector2i(13, 11), Items.LEAF_AUTUMN: Vector2i(14, 11), Items.LEAF_FERN: Vector2i(15, 11),
	Items.MUSHROOM_BROWN: Vector2i(0, 12), Items.FLOWER_BUD: Vector2i(1, 12), Items.LOG_BRANCH: Vector2i(2, 12), Items.FLOWER_POT_1: Vector2i(3, 12), Items.FLOWER_POT_2: Vector2i(4, 12), Items.FLOWER_POT_3: Vector2i(5, 12), Items.MONEY_BAG: Vector2i(6, 12), Items.GOLD_COIN: Vector2i(7, 12), Items.COPPER_STACK: Vector2i(8, 12), Items.SILVER_STACK: Vector2i(9, 12), Items.GOLD_STACK: Vector2i(10, 12), Items.GOLD_SACK: Vector2i(11, 12),
	# Items.HANDED_COINS: Vector2i(12, 12), Items.PAYNG_COINS: Vector2i(13, 12),
	Items.CRYSTAL_SHARDS: Vector2i(14, 12), Items.RUBY_GEM: Vector2i(15, 12),
	Items.BOOK_BLUE: Vector2i(0, 13), Items.BOOK_RED: Vector2i(1, 13), Items.BOOK_GREEN: Vector2i(2, 13), Items.BOOK_YELLOW: Vector2i(3, 13), Items.BOOK_BLACK: Vector2i(4, 13), Items.BOOK_BROWN: Vector2i(5, 13), Items.BLUE_SPELLBOOK: Vector2i(6, 13), Items.RED_SPELLBOOK: Vector2i(7, 13), Items.BOOK_READING: Vector2i(8, 13), Items.ENVELOPE: Vector2i(9, 13), Items.SCROLL_TIED: Vector2i(10, 13), Items.PAPER_DOCUMENT: Vector2i(11, 13), Items.TREASURE_MAP: Vector2i(12, 13), Items.DICE: Vector2i(13, 13), Items.PLAYING_CARD_ACE: Vector2i(14, 13), Items.WINE_BOTTLE: Vector2i(15, 13),
	Items.APPLE: Vector2i(0, 14), Items.BANANA: Vector2i(1, 14), Items.PEAR: Vector2i(2, 14), Items.LEMON: Vector2i(3, 14), Items.STRAWBERRY: Vector2i(4, 14), Items.GRAPES: Vector2i(5, 14), Items.CARROT: Vector2i(6, 14), Items.CORN: Vector2i(7, 14), Items.GARLIC: Vector2i(8, 14), Items.TOMATO: Vector2i(9, 14), Items.EGGPLANT: Vector2i(10, 14), Items.CHILI_PEPPER: Vector2i(11, 14), Items.MUSHROOM_WHITE: Vector2i(12, 14), Items.BREAD_LOAF: Vector2i(13, 14), Items.BAGUETTE: Vector2i(14, 14), Items.ROAST_CHICKEN: Vector2i(15, 14),
	Items.CHICKEN_LEG: Vector2i(0, 15), Items.STEAK_RAW: Vector2i(1, 15), Items.HAM_BONE: Vector2i(2, 15), Items.MEAT_RIB: Vector2i(3, 15), Items.FISH_FILLET: Vector2i(4, 15), Items.EGGS_BASKET: Vector2i(5, 15), Items.EGG_SINGLE: Vector2i(6, 15), Items.CHEESE_WEDGE: Vector2i(7, 15), Items.WATER_BOTTLE: Vector2i(8, 15), Items.HONEY_POT: Vector2i(9, 15), Items.FLOUR_BAG: Vector2i(10, 15), Items.SPICE_BAG: Vector2i(11, 15), Items.CANDY: Vector2i(12, 15), Items.CAKE_SLICE: Vector2i(13, 15), Items.COFFEE_MUG: Vector2i(14, 15),
	Items.FISHING_ROD: Vector2i(0, 16), Items.FISHING_HOOK: Vector2i(1, 16), Items.EARTHWORM: Vector2i(2, 16), Items.FISH_BLUE: Vector2i(3, 16), Items.FISH_BROWN: Vector2i(4, 16), Items.EEL: Vector2i(5, 16), Items.FISH_YELLOW: Vector2i(6, 16), Items.CLOWNFISH: Vector2i(7, 16), Items.JELLYFISH: Vector2i(8, 16), Items.OCTOPUS: Vector2i(9, 16), Items.TURTLE: Vector2i(10, 16), Items.FISH_SKELETON: Vector2i(11, 16), Items.SHELL: Vector2i(12, 16), Items.CHEST_TREASURE: Vector2i(13, 16),
	Items.LOG_WOOD: Vector2i(0, 17), Items.STONE_BLOCK: Vector2i(1, 17), Items.ORE_BLUE: Vector2i(2, 17), Items.GOLD_BAR: Vector2i(3, 17), Items.DIAMOND: Vector2i(4, 17), Items.COTTON_BOLL: Vector2i(5, 17), Items.YARN_BALL: Vector2i(6, 17), Items.FABRIC_ROLL: Vector2i(7, 17), Items.LEATHER_HIDE: Vector2i(8, 17), Items.MONSTER_TOOTH: Vector2i(9, 17), Items.FEATHER: Vector2i(10, 17),
	Items.ORB_RED: Vector2i(0, 18), Items.ORB_BLUE: Vector2i(1, 18), Items.ORB_GREEN: Vector2i(2, 18), Items.ORB_YELLOW: Vector2i(3, 18), Items.ORB_PURPLE: Vector2i(4, 18), Items.ORB_BLACK: Vector2i(5, 18),
}
const SIZE := 32

@export var item: Items = Items.EMPTY:
	set(v):
		if item != v:
			item = v
			if is_node_ready():
				_update_item()

var item_name: String:
	get:
		return Items.keys()[item].capitalize()

@onready var slot_item_texture: TextureRect = $SlotItemTexture
@onready var slot_background: TextureRect = $SlotBackground


func _ready() -> void:
	_update_item()
	slot_item_texture.mouse_entered.connect(_on_mouse_entered)
	slot_item_texture.mouse_exited.connect(_on_mouse_exited)
	slot_background.self_modulate = Color.AQUAMARINE


static func item_to_texture_rect(i: Items) -> Rect2:
	var start_coord = REGION_LOCATION[i] * SIZE as Vector2
	return Rect2(start_coord, Vector2(SIZE, SIZE))


func set_background(category: ItemCategories) -> void:
	if category in CategoryToColor:
		slot_background.self_modulate = CategoryToColor[category]


func _update_item() -> void:
	if slot_item_texture.texture is AtlasTexture:
		slot_item_texture.texture.region = item_to_texture_rect(item)


func pick_random_item_from_category(category: ItemCategories = ItemCategories.NONE) -> void:
	match category:
		ItemCategories.WEAPON:
			item = WEAPONS.pick_random()
		ItemCategories.ARMOUR:
			item = ARMOURS.pick_random()
		ItemCategories.FOOD:
			item = FOODS.pick_random()
		ItemCategories.LOOT:
			item = LOOTS.pick_random()
		ItemCategories.NONE:
			item = pick_random_item()
		_:
			item = pick_random_item()


static func pick_random_item() -> Items:
	var random_item = Items.values().pick_random()
	while random_item == Items.EMPTY:
		random_item = Items.values().pick_random()
	return random_item


func _on_mouse_entered() -> void:
	if not item or item == Items.EMPTY or Game.is_dragging:
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
			if item and item != Items.EMPTY and not Game.is_dragging:
				Sounds.grab()
				Events.drag_started.emit(item, self)
				item = Items.EMPTY
			elif Game.is_dragging:
				if item and item == Game.dragging and Game.recycled:
					Events.items_combined.emit(item, self)
					item = SlottedItem.Items.EMPTY
					Events.drag_ended.emit()
					Events.drag_started.emit(Game.dragging, self)
					Sounds.merge()
				elif item:
					var old_item = item
					item = Game.dragging
					Events.drag_ended.emit()
					Events.drag_started.emit(old_item, self)
					Sounds.grab()
				else:
					item = Game.dragging
					Events.drag_ended.emit()
					Sounds.put_down()
		elif mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.is_pressed():
			if item and item != Items.EMPTY and not Game.recycled:
				var out_slots = get_tree().get_nodes_in_group("outgoing_slot")
				var index_of_empty: int = out_slots.find_custom(func(s): return s.item == Items.EMPTY)
				if index_of_empty == -1:
					return
				var free_outgoing_slot: OutgoingSlot = out_slots[index_of_empty]
				free_outgoing_slot.item = item
				item = Items.EMPTY
				Sounds.grab()
