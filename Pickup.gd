extends Area2D

class_name Pickup

func get_class():
	return "Pickup"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(overlaps_body(Player)):
		Pickup()
		
func Pickup():
	queue_free()
	pass
