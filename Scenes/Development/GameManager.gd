extends Node2D

var gameStarted = false
var paused = false

var timer = 0.0;
var score = 0

var HighHeelUpgrade
var ShadeUpgrade
var WhigUpgrade

var AttackDirection = 1

var highHeelObject = load("res://Player/Weapons/HighHeel.tscn")
var shadeObject = load("res://Player/Weapons/SassAura.tscn")
var whigObject = load("res://Player/Weapons/Whig.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func UpgradeList():
	Ui.UpgradeList.show()
	var arrayUpgradesAvailable = []
	
	for _i in Ui.Upgrades.get_children():
		if(_i.is_visible_in_tree()):
			arrayUpgradesAvailable.push_back(_i)
	
	for _i in arrayUpgradesAvailable:
		if(_i.has_method("grab_focus")):
			_i.grab_focus()
			break

func AddUpgrade(upgrade):
	if(upgrade == "HighHeel"):
		if(HighHeelUpgrade == null):
			var newWeapon = highHeelObject.instance()
			Player.Weapons.add_child(newWeapon)
			HighHeelUpgrade = newWeapon
		else:
			HighHeelUpgrade.level +=1
			HighHeelUpgrade.onUpgrade()
	elif(upgrade == "Whig"):
		if(WhigUpgrade == null):
			var newWeapon = whigObject.instance()
			Player.Weapons.add_child(newWeapon)
			WhigUpgrade = newWeapon
		else:
			WhigUpgrade.level +=1
			WhigUpgrade.onUpgrade()
	elif(upgrade == "Shade"):
		if(ShadeUpgrade == null):
			var newWeapon = shadeObject.instance()
			Player.Weapons.add_child(newWeapon)
			ShadeUpgrade = newWeapon
		else:
			ShadeUpgrade.level +=1
			ShadeUpgrade.onUpgrade()
	else:
		print("This upgrade doesn't exist...")
		
func startGame():
	Ui.Canvas.show()
	Ui.Greyout.show()
	paused = true
	UpgradeList()
# Called when the node enters the scene tree for the first time.
func _ready():
	startGame()
	pass # Replace with function body.

func _process(delta):
	if(!gameStarted):
		return
	if(paused):
		return
	timer+=delta
	Ui.updateUI()
	findClosestEnemy()
	if(Player.curExp>=Player.maxExp):
		Player.curExp = 0
		Player.maxExp = Player.maxExp * 3.5
		Ui.EXPbar.max_value = Player.maxExp
		Ui.updateUI()
		TriggerUpgrade()
		
func onPlayerDeath():
	paused = true
	
func TriggerUpgrade():
	Ui.Canvas.show()
	Ui.Greyout.show()
	paused = true
	UpgradeList()


func findClosestEnemy():
	var enemies = get_tree().get_nodes_in_group("enemyList")
	if(enemies.size() <= 0):
		return
	var nearest_enemy = enemies[0]
	
	for enemy in enemies:
		if enemy.global_position.distance_to(Player.global_position) < nearest_enemy.global_position.distance_to(Player.global_position):
			nearest_enemy = enemy
	if(nearest_enemy.global_position.x < Player.global_position.x):
		AttackDirection = 0
	else:
		AttackDirection = 1
