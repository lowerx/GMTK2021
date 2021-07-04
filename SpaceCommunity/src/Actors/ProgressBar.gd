extends ProgressBar

onready var character = $Player

#func _ready():
	#character.connect("damaged", self, "_on_character_damage_taken")


func _on_character_damage_taken(impact):
	value = character.hp
