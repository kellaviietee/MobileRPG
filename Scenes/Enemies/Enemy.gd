extends Node2D
class_name Enemy
@onready
var hpLabel = $HPLabel as Label
@onready
var animationPlayer = $AnimationPlayer as AnimationPlayer
signal died
signal end_turn
@export
var hp:int = 25:
	set(value):
		hp = value
		if hpLabel:
			hpLabel.text = str(hp)+"hp"
@export
var min_damage:int = 3
@export 
var max_damage:int = 5

var battleUnits:Resource = preload("res://Resources/Battleunits.tres")
var statsResource = preload("res://Resources/Stats.tres")
var damage_animation = preload("res://Scenes/damage_text.tscn")
func _ready() -> void:
	battleUnits.enemy = self

func _exit_tree() -> void:
	battleUnits.enemy = null
	

func attack() -> void:
	await get_tree().create_timer(0.4).timeout
	animationPlayer.play("Attack")
	await animationPlayer.animation_finished
	var error = emit_signal("end_turn")
	if error != OK:
		print("problem with ending enemy turn")

func take_damage(amount):
	self.hp -= amount
	take_damage_animation(amount)
	if is_dead():
		var error = emit_signal("died")
		if error != OK:
			print("Problem with enemy dying signal")
		queue_free()
	else:
		animationPlayer.play("shake")
		

func take_damage_animation(amount):
	var hp_change = damage_animation.instantiate() as HealthDamage
	hpLabel.add_child(hp_change)
	hp_change.damageLabel = amount

func deal_damage():
	randomize()
	var damage = randi_range(min_damage, max_damage)
	if battleUnits.playerStats:
		battleUnits.playerStats.hp -= damage
	var stats = statsResource.StatsPanel as StatsPanel
	if stats:
		stats.show_hp_change(damage)

func is_dead():
	return hp <= 0
