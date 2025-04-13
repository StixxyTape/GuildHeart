extends Node

#@export var questGoals : Dictionary[String, int] = {
	#"Strength" : 10, 
	#"Defence" : 0,
	#"Evasion" : 0,
	#"Magic" : 12,
	#"Charisma" : 0
#}
#
#var relevantGoals : Dictionary[String, int]
#
#func _ready() -> void:
	#for goal in questGoals:
		#if questGoals[goal] > 0:
			#relevantGoals[goal] = questGoals[goal]
#
#func InitialiseGoals():
	#var goalList : Array[String]
	#
	#for goal in questGoals:
		#goalList.append(goal)
		#
	#var newGoalList : Array[String]
	#
	#var goal1 : int = randi_range(0, len(goalList) - 1)
	#newGoalList.append(goalList[goal1])
	#goalList.remove_at(goal1)
	#
	#var goal2 : int = randi_range(0, len(goalList) - 1)
	#newGoalList.append(goalList[goal2])
	#goalList.remove_at(goal2)
		#
	#questGoals[newGoalList[0]] = randi_range(10, 20)
	#questGoals[newGoalList[1]] = randi_range(10, 20)
#
	#for goal in questGoals:
		#if questGoals[goal] > 0:
			#relevantGoals[goal] = questGoals[goal]
