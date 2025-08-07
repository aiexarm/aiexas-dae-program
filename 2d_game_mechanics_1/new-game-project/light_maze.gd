extends Node2D

# This is the main scene controller
# You can add game logic here like:
# - Game state management
# - Level completion
# - UI updates
# - Sound effects

func _ready():
	print("Maze game started!")
	
# Optional: Add any game-wide input handling here
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		# ESC key to quit (optional)
		get_tree().quit()
