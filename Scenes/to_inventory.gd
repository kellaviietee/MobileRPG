extends TextureButton

var battleResource = preload("res://Resources/Battle.tres")

func _on_pressed() -> void:
	var battle:Battle = battleResource.battle
	battle.show_inventory()
