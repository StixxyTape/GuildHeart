extends Node

@onready var heroPref : PackedScene = preload("res://Hero/Hero.tscn")

var heroesForHire : Array[Node]

func CreateHero():
	var newHero = heroPref.instantiate()
	newHero.InitialiseStats()

	return newHero
	
func AddHeroToRoster(hero : Node):
	print("wow")
	add_child(hero)

func UpdateHeroesForHire():
	heroesForHire = [
		CreateHero(),
		CreateHero(),
		CreateHero()
	]

func RemoveHeroForHire(hero : Node):
	if hero in heroesForHire:
		heroesForHire.erase(hero)

	
