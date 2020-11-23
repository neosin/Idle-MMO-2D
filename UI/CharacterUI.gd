extends Control
#Tabs
onready var tabs = $TabContainer
onready var stats_tab = $TabContainer/Stats
onready var abilities_tab = $TabContainer/Abilities
onready var party_tab = $TabContainer/Party

#inspect
onready var title_row = $TabContainer/Stats/Title
onready var health_row = $TabContainer/Stats/RowHP
onready var mana_row = $TabContainer/Stats/RowMana
onready var class_row = $TabContainer/Stats/RowClass
onready var strength_row = $TabContainer/Stats/RowStr
onready var intelligence_row = $TabContainer/Stats/RowInt
onready var agility_row = $TabContainer/Stats/RowAgi
onready var constitution_row = $TabContainer/Stats/RowCon
onready var experience_row = $TabContainer/Stats/RowExp
onready var level_row = $TabContainer/Stats/RowLevel
onready var state_row = $TabContainer/Stats/RowStatus
onready var task_row = $TabContainer/Stats/RowTask/OptionButton
onready var hunt_enemy_row = $TabContainer/Stats/EnemyType/OptionButton

#abilities
onready var ability_row_1 = $TabContainer/Abilities/AbilityList/AbilityRow
onready var ability_row_2 = $TabContainer/Abilities/AbilityList/AbilityRow2
onready var ability_row_3 = $TabContainer/Abilities/AbilityList/AbilityRow3

#party
onready var new_party_name = $TabContainer/Party/HBoxContainer/TextEdit
onready var party_list = $TabContainer/Party/PartyList


var health setget set_health
func set_health(value):
	health = value
	health_row.get_node("Value").text = str(value)
	
var max_health setget set_max_health
func set_max_health(value):
	max_health = value
	health_row.get_node("Max").text = str(value)

var mana setget set_mana
func set_mana(value):
	mana = value
	mana_row.get_node("Value").text = str(value)
	
var max_mana setget set_max_mana
func set_max_mana(value):
	max_mana = value
	mana_row.get_node("Max").text = str(value)

var character_class setget set_character_class
func set_character_class(value):
	character_class = value
	class_row.get_node("Value").text = value.name

var strength setget set_strength
func set_strength(value):
	strength = value
	strength_row.get_node("Value").text = str(value)
	
var intelligence setget set_intelligence
func set_intelligence(value):
	intelligence = value
	intelligence_row.get_node("Value").text = str(value)
	
var agility setget set_agility
func set_agility(value):
	agility = value
	agility_row.get_node("Value").text = str(value)
	
var constitution setget set_constitution
func set_constitution(value):
	constitution = value
	constitution_row.get_node("Value").text = str(value)
	
var state setget set_state
func set_state(value):
	state = value
	state_row.get_node("Value").text = str(value)	

var experience setget set_experience
func set_experience(value):
	experience = value
	experience_row.get_node("Value").text = str(experience)	
	
var level setget set_level
func set_level(value):
	level = value
	level_row.get_node("Value").text = str(level)	


func _ready():
	visible = false
	task_row.add_item("Town", Global.Tasks.Town)
	task_row.add_item("Hunt", Global.Tasks.Hunt)
	
	hunt_enemy_row.add_item("None",-1)
	hunt_enemy_row.add_item("Mouse", Global.Enemies.Mouse)
	hunt_enemy_row.add_item("Bat", Global.Enemies.Bat)
	
func _process(_delta):
	var git = Global.InspectTarget
	
	if git != null:
		if git.is_in_group("Characters"):
			visible = true
			display_character_screen()
		else:
			visible = false
		
	else:
		visible = false
		


func display_character_screen():	
	match tabs.current_tab:
		0: #stats
			display_character_stats()
		1: #abilities
			display_abilities_screen()
		2: #party	
			display_party_screen()
	
func display_character_stats():
	var target = Global.InspectTarget
	var stats = target.stats
	title_row.text = target.character_name

	set_health(stats.health)
	set_max_health(stats.max_health)
	set_mana(stats.mana)
	set_max_mana(stats.max_mana)
	set_character_class(stats.character_class)
	set_strength(stats.strength)
	set_intelligence(stats.intelligence)
	set_agility(stats.agility)
	set_constitution(stats.constitution)
	set_experience(stats.experience)
	set_level(stats.level)
	set_state(Global.get_state_name(target.state))
	task_row.select(target.task)
	hunt_enemy_row.select(-1)
	if target.task == Global.Tasks.Hunt:
		hunt_enemy_row.get_parent().visible = true
	else:
		hunt_enemy_row.get_parent().visible = false


func display_abilities_screen():
	var git : Character = Global.InspectTarget
	if git.character_class.ability_1 != null:
		ability_row_1.visible = true
		
		if git.stats.level < git.character_class.ability_1.level_required:
			ability_row_1.get_node("Active").disabled = true
			ability_row_1.get_node("VBoxContainer/Warning").visible = true
			ability_row_1.get_node("VBoxContainer/Warning").text = "Level " + str(git.character_class.ability_1.level_required) + " required"
		else:
			ability_row_1.get_node("Active").disabled = false
			ability_row_1.get_node("VBoxContainer/Warning").visible = false
		
		ability_row_1.get_node("VBoxContainer/Name").text = git.character_class.ability_1.name
		if git.ability_manager.active_ability_1 == null:
			ability_row_1.get_node("Active").pressed = false
		else:
			ability_row_1.get_node("Active").pressed = true
	else:
		ability_row_1.visible = false
		
	if git.character_class.ability_2 != null:
		ability_row_2.visible = true
		
		if git.stats.level < git.character_class.ability_2.level_required:
			ability_row_2.get_node("Active").disabled = true
			ability_row_2.get_node("VBoxContainer/Warning").visible = true
			ability_row_2.get_node("VBoxContainer/Warning").text = "Level " + str(git.character_class.ability_2.level_required) + " required"
		else:
			ability_row_2.get_node("Active").disabled = false
			ability_row_2.get_node("VBoxContainer/Warning").visible = false
		
		ability_row_2.get_node("VBoxContainer/Name").text = git.character_class.ability_2.name
		if git.ability_manager.active_ability_2 == null:
			ability_row_2.get_node("Active").pressed = false
		else:
			ability_row_2.get_node("Active").pressed = true
	else:
		ability_row_2.visible = false
		
	if git.character_class.ability_3 != null:
		ability_row_3.visible = true
		
		if git.stats.level < git.character_class.ability_3.level_required:
			ability_row_3.get_node("Active").disabled = true
			ability_row_3.get_node("VBoxContainer/Warning").visible = true
			ability_row_3.get_node("VBoxContainer/Warning").text = "Level " + str(git.character_class.ability_3.level_required) + " required"
		else:
			ability_row_3.get_node("Active").disabled = false
			ability_row_3.get_node("VBoxContainer/Warning").visible = false
		
		ability_row_3.get_node("VBoxContainer/Name").text = git.character_class.ability_3.name
		if git.ability_manager.active_ability_3 == null:
			ability_row_3.get_node("Active").pressed = false
		else:
			ability_row_3.get_node("Active").pressed = true
	else:
		ability_row_3.visible = false
	
func display_party_screen():
	for party in PartyManager.get_parties():
		var create_party_row = true
		
		for node in party_list.get_children():
			if party.name == node.party_name:
				#Existing Party
				if party.is_character_in_party(Global.InspectTarget):
					node.get_node("Party/Join").disabled = true
					node.get_node("Party/Leave").disabled = false
				else:
					node.get_node("Party/Join").disabled = false
					node.get_node("Party/Leave").disabled = true
				
				create_party_row = false
		
		#New Party
		if create_party_row:
			var new_party_row = load("res://UI/PartyRow.tscn").instance()
			new_party_row.party_name = party.name
			
			var join_button : Button = new_party_row.get_node("Party/Join")
			var _join = join_button.connect("pressed",self,"_join_party",[new_party_row.party_name])
			
			var leave_button : Button = new_party_row.get_node("Party/Leave")
			var _leave = leave_button.connect("pressed",self,"_leave_party",[new_party_row.party_name])
			
			party_list.add_child(new_party_row)
	
#select task
func _on_OptionButton_item_selected(index):
	if Global.InspectTarget.party != null:
		Global.InspectTarget.party.set_task(index)
	else:
		Global.InspectTarget.task = index
	if index == Global.Tasks.Hunt:
		display_character_stats()


func _on_enemy_type_selected(enemy):
	enemy -= 1
	#-1 is NONE
	if enemy >= 0:
		if Global.InspectTarget.party != null:
			Global.InspectTarget.party.set_hunting_target(enemy)
		else:
			Global.InspectTarget.set_hunting_target(enemy)


func _create_party():
	PartyManager.create_party(new_party_name.text)
	
func _join_party(name):
	for party in party_list.get_children():
		var character_list = party.get_node("CharacterList")
		if party.party_name == name:
			var character_row = Label.new()
			character_row.text = Global.InspectTarget.character_name
			character_list.add_child(character_row)
		else:
			for character_row in character_list.get_children():
				if character_row.text == Global.InspectTarget.character_name:
					character_list.remove_child(character_row)
			
			
	PartyManager.add_character_to_party(name, Global.InspectTarget)
	
func _leave_party(name):
	for party in party_list.get_children():
		if party.party_name == name:
			var character_list = party.get_node("CharacterList")
			for character_row in character_list.get_children():
				if character_row.text == Global.InspectTarget.character_name:
					character_list.remove_child(character_row)

	PartyManager.remove_character_from_party(name, Global.InspectTarget)


func _on_ability_active_toggled(active, ability_index):
	match ability_index:
		1:
			if active:
				Global.InspectTarget.ability_manager.active_ability_1 = Global.InspectTarget.character_class.ability_1.ability_enum
			else:
				Global.InspectTarget.ability_manager.active_ability_1 = null
		2:
			if active:
				Global.InspectTarget.ability_manager.active_ability_2 = Global.InspectTarget.character_class.ability_2.ability_enum
			else:
				Global.InspectTarget.ability_manager.active_ability_2 = null
		3:
			if active:
				Global.InspectTarget.ability_manager.active_ability_3 = Global.InspectTarget.character_class.ability_3.ability_enum
			else:
				Global.InspectTarget.ability_manager.active_ability_3 = null
