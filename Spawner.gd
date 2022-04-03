extends Area2D

export(String) var enemyPath = ""
export(int) var enemiesSpawned = 1
export(int) var increasePerLevel = 1

var enabled = false

onready var enemyToSpawn = load(enemyPath)

onready var areatoSpawn = $CollisionShape2D

export(float) var timerSpawnMax = 5;
var timerSpawnCur = 0

export(bool) var global = false

func _ready():
	load(enemyPath)
	timerSpawnCur = timerSpawnMax

func _process(delta):
	if(!GM.gameStarted or GM.paused):
		return
	timerSpawnCur+=delta
	if timerSpawnCur >= timerSpawnMax:
		timerSpawnCur = 0
		for i in range(0, enemiesSpawned + (increasePerLevel*(Player.level-1))):
			Spawn()
		
func Spawn():
	var enemySpawn = enemyToSpawn.instance()
	get_parent().add_child(enemySpawn)
	
	Player.SpawnPath.offset = randi()
	enemySpawn.position = Player.SpawnPath.global_position
