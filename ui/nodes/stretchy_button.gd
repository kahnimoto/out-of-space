class_name StretchyButton
extends Node


@export_range(5., 45., 5.) var rotation_limits: float = 25.
@export_range(0., 100., 5., "suffix:%") var disabled_scale: float = 30.

var _tween: Tween

@onready var button: Button = get_parent() as Button


func _ready() -> void:
	assert(button is Button, "Component must be child of Buttons")
	button.pivot_offset_ratio = Vector2.ONE * 0.5
	button.pressed.connect(_on_button_pressed)
	button.button_down.connect(_on_button_move.bind(true))
	button.button_up.connect(_on_button_move.bind(false))
	button.mouse_entered.connect(_on_button_hovered.bind(true))
	button.mouse_exited.connect(_on_button_hovered.bind(false))


func _on_button_pressed() -> void:
	_reset()


func _on_button_move(down: bool) -> void:
	if button.disabled:
		return
	var t := tween()
	var down_scale := Vector2(1.5 * 1.2, 1.5 * 0.8)
	var up_scale := Vector2(1.5, 1.5)
	if down:
		t.tween_property(button, "scale", down_scale, 0.1).from(Vector2.ONE).from(up_scale)
	else:
		t.tween_property(button, "scale", up_scale, 0.1).from(Vector2.ONE).from(down_scale)


func _on_button_hovered(_enter: bool) -> void:
	if button.disabled:
		return
	if _enter:
		var t := tween()
		t.tween_property(button, "scale", Vector2.ONE * 1.5, 0.3).from(Vector2.ONE)
		var st := create_tween()
		st.tween_property(button, "rotation_degrees", rotation_limits, 0.1).from(0.0)
		st.chain().tween_property(button, "rotation_degrees", -rotation_limits, 0.1)
		st.chain().tween_property(button, "rotation_degrees", 0.0, 0.1)
		t.tween_subtween(st)
	else:
		_reset()


func _reset() -> void:
	if _tween:
		_tween.kill()
	button.scale = Vector2.ONE
	button.rotation = 0.0


func tween() -> Tween:
	_reset()
	_tween = create_tween()
	_tween.set_parallel(true)
	#_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_SPRING)
	return _tween


func enable() -> void:
	var t := tween()
	t.tween_property(button, "scale", Vector2.ONE, disabled_scale * 0.01).from(Vector2.ONE * 0.5)
	await _tween.finished
	button.disabled = false


func disable() -> void:
	var t := tween()
	t.tween_property(button, "scale", Vector2.ONE * 0.5, disabled_scale * 0.01).from(Vector2.ONE)
	await _tween.finished
	button.disabled = true
