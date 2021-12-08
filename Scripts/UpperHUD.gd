"""
Content: Upper HUD script.
		 Handle interaction with the upper HUD of the game
"""
extends Panel

var NumberOfLive = 3
var ManaBarValue = 0

func _ready():
	$Mana_Bar.rect_scale.x = (ManaBarValue/100.0)

# Remove a live from the 3 starting lives
func RemoveLive():
	if NumberOfLive == 3:
		$Live_3.visible = not $Live_3.visible
		NumberOfLive -= 1
	elif NumberOfLive == 2:
		$Live_2.visible = not $Live_2.visible
		NumberOfLive = 1
	else:
		$Live_1.visible = not $Live_1.visible
		NumberOfLive = 0
		
func Update_ManaBar(value):
	if ManaBarValue < 100:
		ManaBarValue += value
	if ManaBarValue == 100:
		$AnimationPlayer.play("Last_Flower")
	elif ManaBarValue == 80:
		$AnimationPlayer.play("Third_Flower")
	elif ManaBarValue == 50:
		$AnimationPlayer.play("Second_Flower")
	elif ManaBarValue == 30:
		$AnimationPlayer.play("First_Flower")
	#if ManaBarValue > 100:
	#	ManaBarValue -= 100
	$Mana_Bar.rect_scale.x = (ManaBarValue/100.0)

func Reset_ManaBar():
	ManaBarValue = 0
	$Mana_Bar.rect_scale.x = (ManaBarValue/100.0)
	$Mana.frame = 0
# Get the value of the experience bar in percentage
func Get_ManaBar():
	return ManaBarValue
		
# Get the number of lives remaining
func GetNumberOfLive():
	return NumberOfLive
