extends KinematicBody2D

var curHp = 100
var maxHp = 100

var level = 1
var curExp = 0
var maxExp = 100

onready var animationTree = $AnimationTree

onready var Weapons = $Weapons

onready var sprite = $Sprite

var velocity = Vector2.ZERO
const acceleration = 500
const friction = 500
var speed = 2

var sizeModifier = 0
var duplicator = 0
var hitCapIncrease = 1

var LastDirection = Vector2(1,0)

onready var Camera = $Camera2D

onready var SpawnPath = $Path2D/PathFollow2D

func _ready():
	hide()
	animationTree.active = true
	pass
	
func RefreshPlayer():
	hide()
	for _i in Weapons.get_children():
		_i.queue_free()		
	curExp = 0
	maxExp = 100
	maxHp = 100
	curHp = 100
	GM.timer = 0
	GM.score = 0
	GM.HHUnlocked = false
	GM.SUnlocked = false
	GM.WUnlocked = false
	Ui.updateUI()

func _physics_process(delta):
	if(!GM.gameStarted or GM.paused):
		return
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if(input_vector.x > 0):
		sprite.flip_h = false
	if(input_vector.x < 0):
		sprite.flip_h = true
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/character_state/current", 1)
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		animationTree.set("parameters/character_state/current", 0)
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	var collision_info = move_and_collide(velocity)
	if(collision_info != null):
		if(collision_info.has_method("hit")):
			collision_info.hit()
			
func TakeDamage(damage):
	Ui.updateUI()
	curHp -= damage
	print("taken "+str(damage)+ " dmg..")
	if(curHp <= 0):
		Ui.updateUI()
		print("ded")
		visible = false
		GM.onPlayerDeath()
