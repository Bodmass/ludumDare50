extends CanvasLayer

onready var HPBar = $Body/Panel/HP/Bar
onready var Time = $Body/Panel/HP2/Button/Time
onready var Score = $Body/Panel/HP2/Score
onready var Canvas = $Body
onready var Greyout = $Body/Greyout
onready var UpgradeList = $Body/UpgradeList
onready var Upgrades = $Body/UpgradeList/Panel2/VBoxContainer

func _ready():
	HPBar.min_value = 0
	HPBar.max_value = Player.maxHp
	
func _process(delta):
	pass
	
func updateUI():
	HPBar.value = Player.curHp
	var minutes = floor((GM.timer) / 60)
	var seconds = int(GM.timer) % 60

	var minDisplay = ""
	var secDisplay = ""

	if(minutes < 10):
		minDisplay = "0"+str(minutes)
	else:
		minDisplay = str(minutes)
		
	if(seconds < 10):
		secDisplay = "0"+str(seconds)
	else:
		secDisplay = str(seconds)
		
	Time.text = minDisplay+":"+secDisplay
	
	Score.text = "%012d" % int(GM.score)
