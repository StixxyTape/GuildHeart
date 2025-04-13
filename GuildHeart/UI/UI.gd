extends Node

@onready var heroRoster : Node = get_node("../HeroRoster")
@onready var heroSelection : Node = get_node("../HeroSelection")

@onready var timeManager : Node = get_node("../TimeManager")

var heroesForHireResetGroup : String =  "RHFH"
var heroRosterResetGroup : String = "RHR"
var availableQuestsResetGroup : String = "RAQ"

func _ready() -> void:
	EstablishHeroRosterButton()
	EstablishHeroesForHireButton()
	EstablishNextDayButton()

func ResetUI(resetGroup : String):
	for node in get_tree().get_nodes_in_group(resetGroup):
		node.queue_free()

func EstablishHeroRosterButton():
	var resetGroup : String = heroRosterResetGroup
	ResetUI(resetGroup)
	
	
	var heroRosterButton : Button = Button.new()
	heroRosterButton.add_to_group(resetGroup)
	heroRosterButton.text = "Open Hero Roster"
	heroRosterButton.focus_mode = Control.FOCUS_NONE
	
	heroRosterButton.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	heroRosterButton.position.x += -50
	heroRosterButton.position.y += -75
	
	heroRosterButton.pressed.connect(OpenHeroRoster)
	heroRosterButton.pressed.connect(heroRosterButton.queue_free)
	
	add_child(heroRosterButton)
	
func EstablishHeroesForHireButton():
	var resetGroup : String = heroesForHireResetGroup
	ResetUI(resetGroup)
	
	var heroesForHireButton : Button = Button.new()
	heroesForHireButton.add_to_group(resetGroup)
	heroesForHireButton.text = "Open Heroes For Hire"
	heroesForHireButton.focus_mode = Control.FOCUS_NONE
	
	heroesForHireButton.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	heroesForHireButton.position.x += -200
	heroesForHireButton.position.y += -75
	
	heroesForHireButton.pressed.connect(OpenHeroesForHire)
	heroesForHireButton.pressed.connect(heroesForHireButton.queue_free)
	
	add_child(heroesForHireButton)
	
func EstablishNextDayButton():
	var nextDayButton : Button = Button.new()
	nextDayButton.text = "Go to next day"
	nextDayButton.focus_mode = Control.FOCUS_NONE
	
	nextDayButton.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT)
	nextDayButton.position.x += 50
	nextDayButton.position.y += -75
	
	nextDayButton.pressed.connect(timeManager.NextDay)
	
	add_child(nextDayButton)
	
func OpenHeroRoster():
	#ResetUI()
	
	#EstablishHeroesForHireButton()
	#EstablishNextDayButton()
	
	var resetGroup : String = heroRosterResetGroup
	ResetUI(resetGroup)
	
	var heroRosterBox : VBoxContainer = VBoxContainer.new()
	heroRosterBox.add_to_group(resetGroup)
	heroRosterBox.alignment = BoxContainer.ALIGNMENT_END
	heroRosterBox.add_theme_constant_override("separation", 20)
	
	for hero in heroRoster.get_children():
		var newHeroBoxParent : VBoxContainer = VBoxContainer.new()
		newHeroBoxParent.alignment = BoxContainer.ALIGNMENT_CENTER
		
		var nameLabel : Label = Label.new()
		nameLabel.text = str(hero.firstName, " ", hero.surname)
		nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		newHeroBoxParent.add_child(nameLabel)
		
		var newHeroBox : HBoxContainer = HBoxContainer.new()
		
		for stat in hero.stats:
			var newStatLabel : Label = Label.new()
			newStatLabel.text = str(stat, ": ", hero.stats[stat])
			
			newHeroBox.add_child(newStatLabel)
		
		newHeroBox.alignment = BoxContainer.ALIGNMENT_CENTER
		
		newHeroBoxParent.add_child(newHeroBox)
		
		heroRosterBox.add_child(newHeroBoxParent)
	
	# We set the preset after adding children to account for it not being misaligned
	heroRosterBox.set_anchors_and_offsets_preset(Control.PRESET_CENTER_LEFT)
	heroRosterBox.position.x = 50
	
	add_child(heroRosterBox)
	
	var closeRosterButton = Button.new()
	closeRosterButton.add_to_group(resetGroup)
	closeRosterButton.text = "Close Hero Roster"
	closeRosterButton.focus_mode = Control.FOCUS_NONE
	
	closeRosterButton.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	closeRosterButton.position.x += -50
	closeRosterButton.position.y += -75
	
	closeRosterButton.pressed.connect(ResetUI.bind(resetGroup))
	closeRosterButton.pressed.connect(EstablishHeroRosterButton)
	
	add_child(closeRosterButton)

func OpenHeroesForHire():

	var resetGroup : String = heroesForHireResetGroup
	ResetUI(resetGroup)
	
	var heroSelectionBox : VBoxContainer = VBoxContainer.new()
	heroSelectionBox.add_to_group(resetGroup)
	heroSelectionBox.focus_mode = Control.FOCUS_NONE
	heroSelectionBox.alignment = BoxContainer.ALIGNMENT_END
	heroSelectionBox.add_theme_constant_override("separation", 20)
	
	for hero in heroRoster.heroesForHire:
		var newHeroBoxParent : VBoxContainer = VBoxContainer.new()
		newHeroBoxParent.alignment = BoxContainer.ALIGNMENT_CENTER
		
		var nameLabel : Label = Label.new()
		nameLabel.text = str(hero.firstName, " ", hero.surname)
		nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		newHeroBoxParent.add_child(nameLabel)
		
		var newHeroBox : HBoxContainer = HBoxContainer.new()
	
		for stat in hero.stats:
			var newStatLabel : Label = Label.new()
			newStatLabel.text = str(stat, ": ", hero.stats[stat])
			
			newHeroBox.add_child(newStatLabel)
		
		newHeroBox.alignment = BoxContainer.ALIGNMENT_CENTER
		newHeroBoxParent.add_child(newHeroBox)
		
		var contractHeroButton : Button = Button.new()
		contractHeroButton.text = "Contract Hero"
		contractHeroButton.focus_mode = Control.FOCUS_NONE
		
		contractHeroButton.pressed.connect(heroRoster.AddHeroToRoster.bind(hero))
		contractHeroButton.pressed.connect(newHeroBoxParent.queue_free)
		contractHeroButton.pressed.connect(heroRoster.RemoveHeroForHire.bind(hero))
		contractHeroButton.pressed.connect(OpenHeroRoster)
			
		newHeroBoxParent.add_child(contractHeroButton)
		
		heroSelectionBox.add_child(newHeroBoxParent)
		
	# We set the preset after adding children to account for it not being misaligned
	heroSelectionBox.set_anchors_and_offsets_preset(Control.PRESET_CENTER_RIGHT)
	heroSelectionBox.position.x += -50
	
	add_child(heroSelectionBox)
	
	var closeHeroesForHireButton = Button.new()
	closeHeroesForHireButton.add_to_group(resetGroup)
	closeHeroesForHireButton.text = "Close Heroes For Hire"
	closeHeroesForHireButton.focus_mode = Control.FOCUS_NONE
	
	closeHeroesForHireButton.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	closeHeroesForHireButton.position.x += -200
	closeHeroesForHireButton.position.y += -75
	
	closeHeroesForHireButton.pressed.connect(ResetUI.bind(resetGroup))
	closeHeroesForHireButton.pressed.connect(EstablishHeroesForHireButton)
	
	add_child(closeHeroesForHireButton)

func OpenAvailableQuests():
	
