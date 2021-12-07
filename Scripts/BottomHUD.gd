"""
Content: Bottom HUD Script.
		 Handle interaction with the bottom HUD of the game
"""
extends Panel

var ChoiceUser = 2
var ExpBarValue = 0

# Weapon texture path
const GlovePath = "res://assets/HUD/Weapon/gloves.png"
const BowPath = "res://assets/HUD/Weapon/Bow.png"
const SwordPath = "res://assets/HUD/Weapon/Sword.png"

# Power texture path
const FireElementPath = "res://assets/HUD/Elements/Fire.png"
const IceElementPath = "res://assets/HUD/Elements/Ice.png"
const ThunderElementPath = "res://assets/HUD/Elements/Thunder.png"
const WindElementPath = "res://assets/HUD/Elements/Wind.png"

func _ready():
	pass

# Handle the input of keyboard
func _input(ev):
	if Input.is_key_pressed(KEY_K):
		if ChoiceUser == 0:
			$Weapon.texture = load(GlovePath)
			ChoiceUser += 1
		elif ChoiceUser == 1:
			$Weapon.texture = load(BowPath)
			ChoiceUser += 1
		else:
			$Weapon.texture = load(SwordPath)
			ChoiceUser = 0

# Update the texture of the power element
func Update_ElementPicture(path):
	$Power.texture = load(path)

# Update the exp bar with a value.
# Value is the add percentage.
# Exemple: If value = 10% and ExpBarValue = 20%. In the function ExpBarValue become 30%
func Update_ExpBar(value):
	ExpBarValue += value
	if ExpBarValue > 100:
		ExpBarValue -= 100
	$Exp_Bar.scale.x = (ExpBarValue/100.0)
	
# Get the value of the experience bar in percentage
func Get_ExpBar():
	return ExpBarValue
