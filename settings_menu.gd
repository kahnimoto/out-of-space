extends CanvasLayer

@onready var value_main_volume: Label = %ValueMainVolume
@onready var progress_bar_main_volume: HSlider = %ProgressBarMainVolume
@onready var value_music_volume: Label = %ValueMusicVolume
@onready var progress_bar_music_volume: HSlider = %ProgressBarMusicVolume
@onready var value_sfx_volume: Label = %ValueSFXVolume
@onready var progress_bar_sfx_volume: HSlider = %ProgressBarSFXVolume
@onready var apply_sound_settings_button: Button = %ApplySoundSettingsButton


func _ready() -> void:
	hide()
	progress_bar_main_volume.drag_ended.connect(_on_main_volume_changed)
	progress_bar_music_volume.drag_ended.connect(_on_music_volume_changed)
	progress_bar_sfx_volume.drag_ended.connect(_on_sfx_volume_changed)
	apply_sound_settings_button.pressed.connect(_on_apply)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("settings"):
		if visible:
			_on_apply()
		else:
			show()
	


func _on_apply() -> void:
	set_bus_volume("Master", remap(progress_bar_main_volume.value, 0, 100, 0., 1.0))
	set_bus_volume("Music", remap(progress_bar_music_volume.value, 0, 100, 0., 1.0))
	set_bus_volume("SFX", remap(progress_bar_sfx_volume.value, 0, 100, 0., 1.0))


func set_bus_volume(bus_name: String, volume_ratio: float):
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		AudioServer.set_bus_volume_linear(bus_index, volume_ratio)
	else:
		print("Error: Bus '", bus_name, "' not found")
	hide()


func _on_main_volume_changed(changed: bool) -> void:
	if not changed:
		return
	value_main_volume.text = "%d%%" % int(progress_bar_main_volume.value)


func _on_music_volume_changed(changed: bool) -> void:
	if not changed:
		return
	value_music_volume.text = "%d%%" % int(progress_bar_music_volume.value)


func _on_sfx_volume_changed(changed: bool) -> void:
	if not changed:
		return
	value_sfx_volume.text = "%d%%" % int(progress_bar_sfx_volume.value)
