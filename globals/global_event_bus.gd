extends Node

@warning_ignore_start("unused_signal")

signal tooltip_requested(requester: Object, title: String)
signal tooltip_released(requester: Object)
signal score_changed(new_value: int)
signal drag_started(item: SlottedItem.Items, source: Object)
signal drag_ended
signal drag_aborted
signal next_round(round: Game.Round)
signal round_complete(correct: int, wrong: int)
signal items_combined(item: SlottedItem.Items, slot: SlottedItem)
signal recycle
signal game_complete()
signal recycled_successfully
signal output_slot_changed(slot: OutgoingSlot)
