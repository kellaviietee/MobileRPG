extends TextureButton

var battleResource = preload("res://Resources/Battle.tres")

func _on_pressed() -> void:
	var battle = battleResource.battle as Battle
	battle.show_character_sheet()
