extends Node2D

class_name Weapon

export(float) var attackCD = 2
var attackTimer = 0
var level = 1
var maxLevel = 8

export(int) var damage = 5
export(int) var damage_increase = 2

func _physics_process(delta):
	if(!GM.gameStarted or GM.paused):
		return
	attackTimer +=delta
	if(attackTimer>=attackCD):
		processFrame()
		attackTimer = 0
		Attack()

func Attack():
	pass
	
func onUpgrade():
	pass

func processFrame():
	pass
