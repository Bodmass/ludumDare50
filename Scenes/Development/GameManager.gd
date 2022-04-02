extends Node2D

var gameStarted = false
var paused = false

var timer = 0.0;
var score = 0
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
