extends Node

@onready var UI : Node = get_node("../UI")
@onready var heroRoster : Node = get_node("../HeroRoster")

var dayCount : int = 0

func _ready() -> void:
	heroRoster.UpdateHeroesForHire()

func NextDay():
	dayCount += 1
	print("Day ", dayCount)
	if dayCount % 7 == 0:
		heroRoster.UpdateHeroesForHire()
		UI.OpenHeroesForHire()
			
				
