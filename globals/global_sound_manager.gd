extends Node

@onready var audio_refresh: AudioStreamPlayer = $AudioRefresh
@onready var audio_recycle: AudioStreamPlayer = $AudioRecycle
@onready var audio_error: AudioStreamPlayer = $AudioError
@onready var audio_grab: AudioStreamPlayer = $AudioGrab
@onready var audio_put_down: AudioStreamPlayer = $AudioPutDown
@onready var audio_merge: AudioStreamPlayer = $AudioMerge


#func _ready() -> void:
	#Events.drag_started.connect(func(_i, _s): grab())
	#Events.drag_ended.connect(func(): put_down())
	#Events.drag_aborted.connect(func(): put_down())



func recycle() -> void:
	audio_recycle.play()


func refresh_inventory() -> void:
	audio_refresh.play()


func error() -> void:
	audio_error.play()


func grab() -> void:
	audio_grab.play()


func put_down() -> void:
	audio_put_down.play()


func merge() -> void:
	audio_merge.play()
