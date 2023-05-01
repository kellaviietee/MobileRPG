extends Resource
class_name Inventory

signal items_changed(indexes)
@export
var items :Array[Resource] = [
	null, null, null, null, null, null, null, null, null
]

func set_item(item_index:int, item):
	var previous_item = items[item_index]
	items[item_index] = item
	var error = emit_signal("items_changed",[item_index])
	if error != OK:
		print("problem with setting Item")
	return previous_item
	
func swap_items(item_index, target_item_index):
	var target_item = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = target_item
	var error = emit_signal("items_changed",[item_index, target_item_index])
	if error != OK:
		print("problem with swapping Inventory items")

func remove_item(item_index):
	var previous_item = items[item_index]
	items[item_index] = null
	var error = emit_signal("items_changed",[item_index])
	if error != OK:
		print("problem with removing Inventory Item")
	return previous_item
