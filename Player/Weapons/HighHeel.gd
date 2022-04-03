extends Weapon

onready var highheel_Single = load("res://Player/Weapons/HighHeel_Single.tscn")
var sizeModifier = 0
var passthrough = 0

func Attack():
	for i in range(0, Player.duplicator+1):
		var instanceHeel = highheel_Single.instance()
		get_parent().get_parent().get_parent().add_child(instanceHeel)
		instanceHeel.position = Player.global_position
		instanceHeel.sizeModifier = sizeModifier
		if(GM.AttackDirection == 1):
			instanceHeel.apply_central_impulse(Vector2(50, -150))
		else:
			instanceHeel.apply_central_impulse(Vector2(-50, -150))
			instanceHeel.sprite.flip_h = true
		instanceHeel.Collision.shape.radius = 8 + level
		instanceHeel.hitCap+=passthrough
		yield(get_tree().create_timer(0.1), "timeout")
		
	
func onUpgrade():
	if(level >= maxLevel):
		return
	var even = (level%2)
	if(even):
		sizeModifier = (level + Player.sizeModifier -1)*0.1
	else:
		damage += damage_increase
		passthrough+=1
