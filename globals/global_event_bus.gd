extends Node

@warning_ignore_start("unused_signal")

signal tooltip_requested(requester: Object, title: String)
signal tooltip_released(requester: Object)
signal score_changed(new_value: int)
signal drag_started(item: SlottedItem.Items, source: Object)
signal drag_ended
signal drag_aborted
signal next_round(round_time: float, fill_category: SlottedItem.ItemCategories, trick_category: SlottedItem.ItemCategories)
signal round_complete(correct: int, wrong: int)
