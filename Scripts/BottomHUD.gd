"""
Content: Bottom HUD Script.
		 Handle interaction with the bottom HUD of the game
"""
extends Panel

export var ChoiceUser = 0
export var ChoiceFlower = 0
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

onready var player = get_node("/root/" + get_tree().current_scene.name + "/Player/Sprite")

func _ready():
	$Weapon.texture = load(SwordPath)
	$Power.texture = load(FireElementPath)
	pass

# Handle the input of keyboard
func _input(ev):
	if Input.is_key_pressed(KEY_F):
		if ChoiceUser == 0:
			$Weapon.texture = load(GlovePath)
			ChoiceUser += 1
		elif ChoiceUser == 1:
			$Weapon.texture = load(BowPath)
			ChoiceUser += 1
		else:
			$Weapon.texture = load(SwordPath)
			ChoiceUser = 0
	if Input.is_key_pressed(KEY_G):
		if ChoiceFlower == 0:
			$Power.texture = load(FireElementPath)
			player.texture = load("res://assets/Characters/MainCharacter/red_adventurer-one-sheet.png")
			ChoiceFlower += 1
		elif ChoiceFlower == 1:
			$Power.texture = load(IceElementPath)
			player.texture = load("res://assets/Characters/MainCharacter/blue_adventurer-one-sheet.png")
			ChoiceFlower += 1
		elif ChoiceFlower == 2:
			$Power.texture = load(ThunderElementPath)
			player.texture = load("res://assets/Characters/MainCharacter/yellow_adventurer-one-sheet.png")
			ChoiceFlower += 1
		else:
			$Power.texture = load(WindElementPath)
			player.texture = load("res://assets/Characters/MainCharacter/green_adventurer-one-sheet.png")
			ChoiceFlower = 0

# Update the texture of the power element
func Update_ElementPicture(path):
	$Power.texture = load(path)
