extends ActionButton

@export var slash:PackedScene

func _on_pressed():
	var enemy = battleUnits.enemy
	var playerStats = battleUnits.playerStats
	if enemy and playerStats:
		create_slash(enemy.global_position)
		enemy.take_damage(4)
		playerStats.mp += 2
		playerStats.ap -= 1
		

func create_slash(pos):
	var slash_instance = slash.instantiate()
	var main = get_tree().current_scene
	main.add_child(slash_instance)
	slash_instance.global_position = pos
