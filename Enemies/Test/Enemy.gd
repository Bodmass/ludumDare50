extends RigidBody2D

export(float) var speed = 1
export(int) var damage = 5
export(int) var maxHp = 5
var curHp = 5
var motion = Vector2.ZERO

func get_class():
	return "Enemy"

# Called when the node enters the scene tree for the first time.
func _ready():
	curHp
	pass # Replace with function body.
	
func _physics_process(delta):
	if(!GM.gameStarted or GM.paused):
		return
	motion = position.direction_to(Player.position) * speed
	apply_central_impulse(motion)
	if(motion.x > 0):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func hit():
	Player.TakeDamage(damage)

func _on_Enemy_body_entered(body):
	if(body == Player):
		queue_free()
	pass # Replace with function body.
	
func enemyhit(damage):
	curHp -= damage
	if(curHp <= 0):
		GM.score +=5
		queue_free()
	
func _on_Area2D_body_entered(body):
	if(body == Player):
		hit()
