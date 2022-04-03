extends CanvasLayer

var Scene = load("res://Scenes/Development/Aziz's Test Environment.tscn")

func _ready():
	GM.gameStarted = false
	GM.paused = false
	Ui.Greyout.hide()
	Ui.UpgradeList.hide()
	GM.timer = 0
	GM.score = 0
	for _i in Player.Weapons.get_children():
		_i.queue_free()		
	$Body/Panel2/HSLabel.text = "High Score: "+"%012d" % int(GM.getHighScore())
	$Body/Panel2/Play.grab_focus()
	pass # Replace with function body.

func _on_Play_button_up():
	get_tree().change_scene_to(Scene)
	pass # Replace with function body.
