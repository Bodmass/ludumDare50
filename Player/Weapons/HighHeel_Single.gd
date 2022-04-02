extends Weapon

onready var sprite = $Sprite
onready var Collision = $Area2D/CollisionShape2D
var sizeModifier = 0
var amountHit = 0
var hitCap = 1

func _process(delta):
	sprite.scale.x = 1+sizeModifier
	sprite.scale.y = 1+sizeModifier
	sprite.rotation += delta * 5

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if(body.has_method("enemyhit")):
		body.enemyhit(damage)
		amountHit+=1
		if(amountHit >= (hitCap + Player.hitCapIncrease)):
			queue_free()

