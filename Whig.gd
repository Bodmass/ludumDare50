extends Weapon

onready var animationTree = $AnimationTree
var playback

onready var Raycasts = $Raycasts
onready var Collision = $Whig_Anchor/Area2D/CollisionShape2D

func _ready():
	animationTree.active = true
	playback = animationTree.get("parameters/playback")

func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_page_up")):
		level+=1;
		onUpgrade()

func Attack():
	playback.travel("Whig-whip")
	get_tree().call_group("enemyWhipRange", "enemyhit", damage)
	
func onUpgrade():
	if(level >= maxLevel+1):
		return
	var even = (level%2)
	print(level)
	if(even):
		var SizeModifierX = ((level + Player.sizeModifier) -1)*0.4
		var SizeModifierY =  ((level + Player.sizeModifier) -1)*0.1

		scale.x = 2+SizeModifierX
		scale.y = 1+SizeModifierY
		
		Collision.shape.extents.x = 32 + (16*(level+Player.sizeModifier-1))
		Collision.shape.extents.y = 5 + (2*(level+Player.sizeModifier-1))
		Collision.position.x = 32 + (16*(level+Player.sizeModifier-1))
		Collision.position.y = 0
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
