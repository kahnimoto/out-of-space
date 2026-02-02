extends Node

@warning_ignore_start("unused_signal")

signal tooltip_requested(requester: Object, title: String)
signal tooltip_released(requester: Object)
signal new_item_requested
signal score_changed(new_value: int)
signal drag_started(item: SlottedItem.Items)
signal drag_ended()
signal drag_aborted()
