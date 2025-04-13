extends Node

var tempo : int

var stats : Dictionary[String, int]

var firstName : String
var surname : String

#func HeroAction(actionCounter : int):
	#print(quest.relevantGoals)
	#
	#var statScore : int = 0
	#var statName : String
	#
	#for stat in relevantStats:
		#if stat in quest.relevantGoals and relevantStats[stat] > statScore:
			#statScore = relevantStats[stat]
			#statName = stat
	#
	#if statScore == 0:
		#print("hero couldn't help")
		#return
#
	#quest.relevantGoals[statName] -= randi_range(1, statScore)
	#
	#if quest.relevantGoals[statName] <= 0:
		#quest.relevantGoals.erase(statName)

func InitialiseStats():
	while len(stats) < 3:
		var randStat : int = randi_range(0, len(Global.globalStats) - 1)
		var randStatName : String = Global.globalStats[randStat]
		if randStatName not in stats:
			stats[randStatName] = randi_range(1, 4)
	
	firstName = Global.globalFirstNames[randi_range(0, len(Global.globalFirstNames) - 1)]
	surname = Global.globalSurnames[randi_range(0, len(Global.globalSurnames) - 1)]
			
