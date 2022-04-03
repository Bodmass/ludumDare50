extends Pickup

func Pickup():
	var randomUpgrade = randi()%2
	if(randomUpgrade == 0):
		Player.duplicator+=1
	if(randomUpgrade == 1):
		Player.hitCapIncrease+=1
	if(randomUpgrade == 2):
		Player.sizeModifier+=1
	queue_free()
