extends ActionButton


func _on_pressed():
	var playerStats = battleUnits.playerStats
	if playerStats:
		if playerStats.mp >= 8:
			playerStats.hp += 5
			playerStats.mp -= 8
			playerStats.ap -= 1
			stats.show_hp_change(-5)
