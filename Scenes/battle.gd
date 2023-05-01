extends Node
class_name Battle

@onready
var actionButtons = $UI/BattleActionButtons as GridContainer
@onready
var animationPlayer = $AnimationPlayer as AnimationPlayer
@onready
var nextRoomButton = $UI/CenterContainer/NextRoomButton as Button
@onready
var enemyPosition = $EnemyPosition as Marker2D
@onready
var inventoryButtons = $UI/InventoryButtons as GridContainer
var battleUnits:Resource = preload("res://Resources/Battleunits.tres")
@export
var enemies:Array[PackedScene]

var battleResource = preload("res://Resources/Battle.tres")

func _ready() -> void:
	battleResource.battle = self
	randomize()
	start_player_turn()
	var enemy:Enemy = battleUnits.enemy
	if enemy:
		connect_to_enemy(enemy)
		

func _exit_tree() -> void:
	battleResource.battle = null

func start_player_turn() -> void:
	if not is_enemy_dead():
		actionButtons.show()
	var playerStats = battleUnits.playerStats
	playerStats.ap = playerStats.max_ap
	await playerStats.end_turn
	start_enemy_turn()

func start_enemy_turn() -> void:
	actionButtons.hide()
	var enemy = battleUnits.enemy
	if enemy and not enemy.is_queued_for_deletion():
		enemy.attack()
		await enemy.end_turn
	start_player_turn()

func create_new_enemy():
	enemies.shuffle()
	var enemy_scene = enemies.front() as PackedScene
	var enemy = enemy_scene.instantiate() as Enemy
	enemyPosition.add_child(enemy)
	connect_to_enemy(enemy)
	
	
func _on_enemy_died():
	nextRoomButton.show()
	inventoryButtons.show()
	actionButtons.hide()

func _on_next_room_button_pressed() -> void:
	nextRoomButton.hide()
	inventoryButtons.hide()
	animationPlayer.play("FadeToNewRoom")
	await animationPlayer.animation_finished
	var playerStats = battleUnits.playerStats as PlayerStats
	playerStats.ap = playerStats.max_ap
	actionButtons.show()
	create_new_enemy()

func connect_to_enemy(enemy):
	var callable = Callable(self, "_on_enemy_died")
	var error = enemy.died.connect(callable)
	if error != OK:
		print("Problem connecting to enemy")

func is_enemy_dead() -> bool:
	var enemy = battleUnits.enemy as Enemy
	return enemy.is_queued_for_deletion()

func show_inventory():
	animationPlayer.play("ShowInventory")

func hide_inventory():
	animationPlayer.play_backwards("ShowInventory")

func show_character_sheet():
	animationPlayer.play("ShowCharacterSheet")

func hide_character_sheet():
	animationPlayer.play_backwards("ShowCharacterSheet")
