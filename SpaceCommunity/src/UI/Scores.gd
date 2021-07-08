extends VBoxContainer


func _process(delta):
	$Coins.text = "Coins: " + str(AutoLoad.coins)
	$DevelopmentIndex.text = "Development Index: " + str(AutoLoad.development_index)
