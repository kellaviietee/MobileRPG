extends Node
class_name PlayerStats

var battleUnits:Resource = preload("res://Resources/Battleunits.tres")

var max_hp = 25

var hp = max_hp:
	set(value):
		hp = clamp(value, 0, max_hp)
		var error = emit_signal("hp_changed",hp)
		if error != OK:
			print("problem with updating HP")
var max_mp = 10

var mp = max_mp:
	set(value):
		mp = clamp(value, 0, max_mp)
		var error = emit_signal("mp_changed",mp)
		if error != OK:
			print("problem with updating HP")

var max_ap = 3

var ap = max_ap:
	set(value):
		ap = clamp(value, 0, max_ap)
		var error = emit_signal("ap_changed",ap)
		if error != OK:
			print("problem with updating AP")
		if ap == 0:
			var end_error = emit_signal("end_turn")
			if end_error != OK:
				print("problem with ending player turn")

signal hp_changed(value)
signal mp_changed(value)
signal ap_changed(value)
signal end_turn

func _ready() -> void:
	battleUnits.playerStats = self

func _exit_tree() -> void:
	battleUnits.playerStats = null
	
