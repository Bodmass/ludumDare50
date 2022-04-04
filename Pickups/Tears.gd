extends Pickup

func Pickup():
	var randomUpgrade = randi()%5
	if(randomUpgrade == 0):
		Player.duplicator+=1
	if(randomUpgrade == 1):
		Player.hitCapIncrease+=1
	if(randomUpgrade == 2):
		Player.sizeModifier+=1
		if(GM.WUnlocked != false):
			GM.WhigUpgrade.updateMe()
		if(GM.SUnlocked != false):
			GM.ShadeUpgrade.updateMe()
	if(randomUpgrade == 3):
		Player.curExp+= Player.maxExp/4
		
	if(GM.HHUnlocked != false):
		GM.HighHeelUpgrade.updateMe()

	queue_free()
