extends Pickup

export(int) var hpRecovery = 10

func Pickup():
	Player.curHp += hpRecovery
	if(Player.curHp > Player.maxHp):
		Player.curHp = Player.maxHp
	queue_free()
