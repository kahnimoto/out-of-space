extends CanvasLayer

@onready var value_points: Label = %ValuePoints
@onready var ability_button_1: Button = %AbilityButton1
@onready var ability_button_2: Button = %AbilityButton2



func _ready() -> void:
	Events.score_changed.connect(_on_score_changed)
	ability_button_1.pressed.connect(_on_ability_button.bind(1))


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
