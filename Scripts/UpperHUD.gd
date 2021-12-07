"""
Content: Upper HUD script.
		 Handle interaction with the upper HUD of the game
"""
extends Panel

var NumberOfLive = 3

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
		
# Get the number of lives remaining
func GetNumberOfLive():
	return NumberOfLive
