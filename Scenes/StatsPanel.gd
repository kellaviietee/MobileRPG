extends Panel
class_name StatsPanel
@onready
var hpLabel = $StatsContainer/HP as Label
@onready
var apLabel = $StatsContainer/AP as Label
@onready
var mpLabel = $StatsContainer/MP as Label

var healthDamageScene = preload("res://Scenes/damage_text.tscn")
var statsResource = preload("res://Resources/Stats.tres")

func _ready() -> void:
	statsResource.StatsPanel = self

func _exit_tree() -> void:
	statsResource.StatsPanel = null

func _on_player_stats_hp_changed(value) -> void:
	hpLabel.text ="HP\n" + str(value)


func _on_player_stats_ap_changed(value) -> void:
	apLabel.text ="AP\n" + str(value)


func _on_player_stats_mp_changed(value) -> void:
	mpLabel.text ="MP\n" + str(value)

func show_hp_change(damage:int):
	var health_damage = healthDamageScene.instantiate() as HealthDamage
	hpLabel.add_child(health_damage)
	health_damage.damageLabel = damage

func show_ap_change(value:int):
	var ap_change = healthDamageScene.instantiate() as HealthDamage
	apLabel.add_child(ap_change)
	ap_change.damageLabel = value

func show_mp_change(value:int):
	var mp_change = healthDamageScene.instantiate() as HealthDamage
	mpLabel.add_child(mp_change)
	mp_change.damageLabel = value
