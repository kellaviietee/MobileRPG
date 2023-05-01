extends Node2D
class_name HealthDamage
@onready
var damageLabel = $DamageLabel:
	set(value):
		if value > 0:
			damageLabel.text = str(-value) + " hp"
		else:
			damageLabel.text = "+" + str(-value) + " hp"
			

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
