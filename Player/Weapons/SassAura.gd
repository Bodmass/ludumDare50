extends Weapon

onready var ParticleSystem = $CPUParticles2D
onready var Collision = $Area2D/CollisionShape2D

func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_page_up")):
		level+=1;
		onUpgrade()

func Attack():
	get_tree().call_group("enemySassRange", "enemyhit", damage)
	
func onUpgrade():
	if(level >= maxLevel):
		return
	var even = (level%2)
	if(even):
		var SizeModifier = (level + Player.sizeModifier -1)/10
		scale.x = 1+SizeModifier
		scale.y = 1+SizeModifier
		Collision.shape.radius = 36 + (8*(level+Player.sizeModifier-1))
		ParticleSystem.emission_sphere_radius = 36 + (8*(level+Player.sizeModifier-1))
		ParticleSystem.amount = 20 + (10*(level+Player.sizeModifier-1))
	else:
		damage += damage_increase


func _on_Area2D_body_entered(body):
	if(body.get_class() == "Enemy"):
		body.add_to_group("enemySassRange")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if(body.get_class() == "Enemy"):
		body.remove_from_group("enemySassRange")
	pass # Replace with function body.
