extends TextureButton

var battleResource = preload("res://Resources/Battle.tres")




func _on_pressed() -> void:
	var battle = battleResource.battle as Battle
	battle.hide_inventory()
