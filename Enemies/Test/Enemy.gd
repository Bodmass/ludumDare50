extends RigidBody2D

export(float) var speed = 1
export(int) var damage = 5
export(int) var maxHp = 5
export(int) var hpIncreasePLvl = 4
export(int) var expDrop = 20
export(int) var attackCD = 1.0
var lastAttack = 0.0
var curHp = 5
var motion = Vector2.ZERO
#var playerAttackable = false


func get_class():
	return "Enemy"
	
func flashRed():
	$Sprite.modulate = Color(1, 0, 0)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.modulate = Color(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemyList")
	maxHp+=(hpIncreasePLvl*(Player.level-1)+GM.timerCompletions)
	speed+=GM.timerCompletions
	curHp = maxHp
	pass # Replace with function body.
	
func _physics_process(delta):
	lastAttack += delta
	if(!GM.gameStarted or GM.paused):
		return
	motion = position.direction_to(Player.position) * speed
	apply_central_impulse(motion)
	if(motion.x > 0):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	if($Area2D.overlaps_body(Player)):
		if(lastAttack >= attackCD):
			hit()
			#playerAttackable = false
			lastAttack = 0

func hit():
	Player.TakeDamage(damage)

func _on_Enemy_body_entered(body):
	if(body == Player):
		queue_free()
	pass # Replace with function body.
	
func enemyhit(damage):
	curHp -= damage
	flashRed()
	var kbDir = Player.global_position.direction_to(self.global_position)
	print(kbDir)
	apply_central_impulse(kbDir * 100)
	if(curHp <= 0):
		GM.score +=5
		Player.curExp+=expDrop
		if(GM.getLootDrop() == "Food"):
			var food = GM.foodPickup.instance()
			get_parent().add_child(food)
			food.global_position = self.global_position 
			
		if(GM.getLootDrop() == "Tears"):
			var tear = GM.tearPickup.instance()
			get_parent().add_child(tear)
			tear.global_position = self.global_position 
		queue_free()
	
func _on_Area2D_body_entered(body):
	pass

func _on_Area2D_body_exited(body):
	pass
