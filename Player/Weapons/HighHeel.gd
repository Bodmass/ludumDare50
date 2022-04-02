extends Weapon

onready var highheel_Single = load("res://Player/Weapons/HighHeel_Single.tscn")
var sizeModifier = 0

func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_page_up")):
		level+=1;
		onUpgrade()

func Attack():
	for i in range(0, Player.duplicator+1):
		print("spawn Heel")
		var instanceHeel = highheel_Single.instance()
		get_parent().get_parent().get_parent().add_child(instanceHeel)
		instanceHeel.position = Player.global_position
		instanceHeel.sizeModifier = sizeModifier
		instanceHeel.apply_central_impulse(Vector2(50, -150))
		instanceHeel.Collision.shape.radius = 8 + level
		yield(get_tree().create_timer(0.1), "timeout")
	
func onUpgrade():
	if(level >= maxLevel):
		return
	var even = (level%2)
	if(even):
		sizeModifier = (level + Player.sizeModifier -1)*0.1
	else:
		damage += damage_increase
