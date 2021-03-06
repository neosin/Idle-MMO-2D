extends Control

var item : Item

onready var icon = $Background/Icon
onready var label1 = $Background/Label1
onready var label2 = $Background/Label2
onready var label3 = $Background/Label3
onready var label4 = $Background/Label4
onready var label5 = $Background/Label5
onready var label6 = $Background/Label6
onready var label7 = $Background/Label7
onready var label_description = $Background/LabelDescription
onready var value = $Background/Value


func refresh():
	icon.texture = item.icon
	if item.is_weapon:
		label1.text = item.name
		label2.text = str(item.weapon_speed) + " APS"
		label3.text = str(item.min_damage) + " - " + str(item.max_damage) + " dmg"
		label4.text = "+" + str(item.strength) + " str"
		label5.text = "+" + str(item.constitution) + " con"
		label6.text = "+" + str(item.agility) + " agi"
		label7.text = "+" + str(item.intelligence) + " int"
		label_description.text = item.description
		value.text = str(item.calculate_value()) + "g"
	elif item.is_armor:
		label1.text = item.name
		label2.text = str(item.armor) + " armor"
		label3.text = str(item.magic_resist) + " mr"
		label4.text = str("+") + str(item.strength) + " str"
		label5.text = str("+") + str(item.constitution) + " con"
		label6.text = str("+") + str(item.agility) + " agi"
		label7.text = str("+") + str(item.intelligence) + " int"
		label_description.text = item.description
		value.text = str(item.calculate_value()) + "g"
	else:
		label1.text = item.name
		label2.text = ""
		label3.text = ""
		label4.text = ""
		label5.text = ""
		label6.text = ""
		label7.text = ""
		label_description.text = item.description
		value.text = str(item.calculate_value()) + "g"
