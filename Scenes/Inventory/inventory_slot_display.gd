extends CenterContainer
class_name InventorySlotDisplay


var inventory = preload("res://Scenes/Inventory/Inventory.tres")
@onready
var itemTextureRect = $ItemTextureRect
var emptySlot = preload("res://Scenes/Inventory/EmptyInventorySlot.png")

func display_item(item:Item):
	if item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = emptySlot

func _get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.remove_item(item_index) as Item
	if item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		return data

func _can_drop_data(_position,data):
	return data is Dictionary and data.has("item")

func _drop_data(_position,data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_items(my_item_index,data.item_index)
	inventory.set_item(my_item_index,data.item)
	
