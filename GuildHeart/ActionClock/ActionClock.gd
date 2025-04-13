extends Node

@onready var actionTimer : Timer = $ActionTimer
@onready var quest : Node = get_node("../Quest")
 
var actionTime : float = .5
var actionCounter : int = 0
var finalAction : int = 0

func _ready() -> void:
	actionTimer.one_shot = true
	#actionTimer.start(actionTime)
	
func ActionTime() -> void:
	actionCounter += 1
	print("Turn ", actionCounter)
	for hero in quest.get_children():
		if actionCounter % hero.tempo == 0:
			hero.HeroAction(actionCounter)
	
	actionTimer.start(actionTime)
