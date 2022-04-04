extends Node2D

var EndScene = load("res://Scenes/TitleScreen/EndScreen.tscn")

var gameStarted = false
var paused = false

var timer = 0.0;

var timerCompletions = 0

var score = 0

var HHUnlocked = false
var SUnlocked = false
var WUnlocked = false

var HighHeelUpgrade
var ShadeUpgrade
var WhigUpgrade

var AttackDirection = 1

var highHeelObject = load("res://Player/Weapons/HighHeel.tscn")
var shadeObject = load("res://Player/Weapons/SassAura.tscn")
var whigObject = load("res://Player/Weapons/Whig.tscn")

var foodPickup = load("res://Pickups/Food.tscn")
var tearPickup = load("res://Pickups/Tears.tscn")

func getLootDrop():
	var item_id = randi() % 50
	print(item_id)
	if(item_id == 1):
		return "Food"
	elif(item_id == 2):
		return "Tears"
	else:
		return "None"
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
		if(HHUnlocked == false):
			var newWeapon = highHeelObject.instance()
			Player.Weapons.add_child(newWeapon)
			HighHeelUpgrade = newWeapon
			HHUnlocked = true
		else:
			HighHeelUpgrade.level +=1
			HighHeelUpgrade.onUpgrade()
	elif(upgrade == "Whig"):
		if(WUnlocked == false):
			var newWeapon = whigObject.instance()
			Player.Weapons.add_child(newWeapon)
			WhigUpgrade = newWeapon
			WUnlocked = true
		else:
			WhigUpgrade.level +=1
			WhigUpgrade.onUpgrade()
	elif(upgrade == "Shade"):
		if(SUnlocked == false):
			var newWeapon = shadeObject.instance()
			Player.Weapons.add_child(newWeapon)
			ShadeUpgrade = newWeapon
			SUnlocked = true
		else:
			ShadeUpgrade.level +=1
			ShadeUpgrade.onUpgrade()
	else:
		print("This upgrade doesn't exist...")
		
func startGame():
	timerCompletions = 0
	$Timer.start()
	Player.show()
	Ui.Canvas.show()
	Ui.Greyout.show()
	paused = true
	UpgradeList()
# Called when the node enters the scene tree for the first time.
func _ready():
	Ui.Canvas.hide()
	pass

func _process(delta):
	if(!gameStarted):
		return
	if(paused):
		return
	timer+=delta
	Ui.updateUI()

	if(Player.curExp>=Player.maxExp):
		Player.curExp = 0
		Player.maxExp = Player.maxExp * 2.5
		Ui.EXPbar.max_value = Player.maxExp
		Ui.updateUI()
		TriggerUpgrade()
		
func onPlayerDeath():
	paused = true
	$Timer.stop()
	if(score > getHighScore()):
		saveScore()
	get_tree().change_scene_to(EndScene)
	
func TriggerUpgrade():
	Ui.Canvas.show()
	Ui.Greyout.show()
	paused = true
	UpgradeList()
	
var save_path = "user://save.dat"

func saveScore():
	var data = {
		"score" : score,
	}
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
		
func getHighScore():
	var file = File.new()
	if(file.file_exists(save_path)):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			return player_data.score
			file.close()
		return 0
	return 0


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


func _on_Timer_timeout():
	$Timer.start()
	timerCompletions+=1
	#print(timerCompletions)
	pass # Replace with function body.


func _on_CheckEnemy_timeout():
	$CheckEnemy.start()
	if(!gameStarted):
		return
	if(paused):
		return
	findClosestEnemy()
	pass # Replace with function body.
