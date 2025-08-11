extends Control

# UI to display player lives
@onready var lives_label: Label

var player_node: CharacterBody2D

func _ready():
	# Create the lives label
	lives_label = Label.new()
	lives_label.text = "Lives: 3"
	lives_label.position = Vector2(10, 10)  # Top-left corner
	lives_label.add_theme_font_size_override("font_size", 24)
	lives_label.add_theme_color_override("font_color", Color.WHITE)
	add_child(lives_label)
	
	# Find the player node
	await get_tree().process_frame  # Wait one frame for nodes to be ready
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_node = players[0]

func _process(_delta):
	# Update lives display
	if player_node and player_node.has_method("get_current_lives"):
		var current_lives = player_node.get_current_lives()
		var max_lives = player_node.get_max_lives()
		
		lives_label.text = "Lives: " + str(current_lives) + "/" + str(max_lives)
		
		# Change color based on lives remaining
		if current_lives <= 0:
			lives_label.add_theme_color_override("font_color", Color.RED)
			lives_label.text += " - GAME OVER (Press R to restart)"
		elif current_lives == 1:
			lives_label.add_theme_color_override("font_color", Color.ORANGE)
		else:
			lives_label.add_theme_color_override("font_color", Color.WHITE)
