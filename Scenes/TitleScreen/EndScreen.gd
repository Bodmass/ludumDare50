extends CanvasLayer

var Scene = load("res://Scenes/TitleScreen/Title.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	GM.gameStarted = false
	GM.paused = false
	Ui.Greyout.hide()
	Ui.UpgradeList.hide()
	$Body/Panel2/Panel3/Score.text = "High Score: "+"%012d" % int(GM.score)
	$Body/Panel2/Panel3/HSLabel.text = "High Score: "+"%012d" % int(GM.getHighScore())
	$Body/Panel2/Return.grab_focus()
	Player.RefreshPlayer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Return_button_up():
	get_tree().change_scene_to(Scene)
	pass # Replace with function body.
