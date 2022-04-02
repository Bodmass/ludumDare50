extends Node2D

func _ready():
	Player.visible = true
	Player.position = global_position
	queue_free()
