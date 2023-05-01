extends Button
class_name ActionButton

var battleUnits = preload("res://Resources/Battleunits.tres")
var statsResource = preload("res://Resources/Stats.tres")
@onready
var stats = statsResource.StatsPanel as StatsPanel

func _on_pressed() -> void:
	pass # Replace with function body.
