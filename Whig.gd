extends Weapon

onready var animationTree = $AnimationTree
var playback

onready var Raycasts = $Raycasts
onready var RightCollision = $Area2D/RightCollision
onready var LeftCollision = $Area2D/LeftCollision

func _ready():
	animationTree.active = true
	playback = animationTree.get("parameters/playback")

func _physics_process(delta):
	if(GM.AttackDirection == 0):
		$Area2D/LeftCollision.disabled = false
		$Area2D/RightCollision.disabled = true
	if(GM.AttackDirection == 1):
		$Area2D/LeftCollision.disabled = true
		$Area2D/RightCollision.disabled = false

func Attack():
	if(GM.AttackDirection == 0):
		$Whig_Anchor.scale.x = -1
	if(GM.AttackDirection == 1):
		$Whig_Anchor.scale.x = 1
	playback.travel("Whig-whip")
	get_tree().call_group("enemyWhipRange", "enemyhit", damage)

func updateMe():
	var SizeModifierX = ((level + Player.sizeModifier) -1)*0.1
	var SizeModifierY =  ((level + Player.sizeModifier) -1)*0.1

	scale.x = 1+SizeModifierX
	scale.y = 1+SizeModifierY
	
func onUpgrade():
	if(level >= maxLevel+1):
		return
	var even = (level%2)
	print(level)
	if(even):
		var SizeModifierX = ((level + Player.sizeModifier) -1)*0.1
		var SizeModifierY =  ((level + Player.sizeModifier) -1)*0.1

		scale.x = 1+SizeModifierX
		scale.y = 1+SizeModifierY
#˚		
#		RightCollision.shape.extents.x = 32 + (16*(level+Player.sizeModifier-1))
#		RightCollision.shape.extents.y = 5 + (2*(level+Player.sizeModifier-1))
#		RightCollision.position.x = 32 + (16*(level+Player.sizeModifier-1))
#		RightCollision.position.y = 0
#
#		LeftCollision.shape.extents.x = 32 + (16*(level+Player.sizeModifier-1))
#		LeftCollision.shape.extents.y = 5 + (2*(level+Player.sizeModifier-1))
#		LeftCollision.position.x = -32 + (-16*(level+Player.sizeModifier-1))
#		LeftCollision.position.y = 0
	else:
		damage += damage_increase


func _on_Area2D_body_entered(body):
	if(body.get_class() == "Enemy"):
		body.add_to_group("enemyWhipRange")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if(body.get_class() == "Enemy"):
		body.remove_from_group("enemyWhipRange")
	pass # Replace with function body.
