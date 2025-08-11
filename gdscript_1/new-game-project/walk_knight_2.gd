extends CharacterBody2D

@export var speed := 200
@export var spawn_position := Vector2(400, 100)  # Set this to top of your maze
@export var max_lives := 3
var current_lives := 3
var is_dead := false
var is_invincible := false  # Prevent multiple deaths during respawn

func _ready():
	add_to_group("player")
	current_lives = max_lives
	
	# Set spawn position if not set
	if spawn_position == Vector2.ZERO:
		spawn_position = global_position
	
	print("Knight started with ", max_lives, " lives")

func _physics_process(_delta):  # Fixed syntax error here
	# Don't move if dead
	if is_dead:
		return
		
	# Get input direction
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Apply movement
	if dir.length() > 0:
		velocity = dir.normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	# Move the character
	move_and_slide()

func die():
	if is_dead or is_invincible:
		return  # Already dead or invincible, don't process again
		
	is_dead = true
	is_invincible = true
	current_lives -= 1
	
	print("Knight died! Lives remaining: ", current_lives)
	
	# Death visual effect
	modulate = Color(1, 0, 0, 1)  # Red flash
	
	# Check if game over
	if current_lives <= 0:
		game_over_sequence()
	else:
		respawn()

func respawn():
	print("Respawning knight...")
	
	# Stop all movement
	velocity = Vector2.ZERO
	
	# Move to spawn position
	global_position = spawn_position
	
	# Visual feedback - flash effect
	modulate = Color(1, 0, 0, 0.7)  # Red tint when respawning
	
	# Brief invincibility period
	await get_tree().create_timer(0.5).timeout
	modulate = Color(1, 1, 1, 0.5)  # Semi-transparent
	await get_tree().create_timer(0.5).timeout
	modulate = Color(1, 1, 1, 1)  # Back to normal
	
	is_dead = false
	is_invincible = false  # Remove invincibility after respawn
	print("Knight respawned! Lives: ", current_lives)

func game_over_sequence():
	print("GAME OVER - No lives remaining!")
	
	# Visual feedback
	modulate = Color(0.5, 0.5, 0.5, 1)  # Gray out the knight
	
	# Show game over message
	print("Press R or ENTER to restart")
	
	# Wait a moment then show restart option
	await get_tree().create_timer(2.0).timeout

func restart_game():
	print("Restarting game...")
	current_lives = max_lives
	is_dead = false
	is_invincible = false
	modulate = Color(1, 1, 1, 1)
	global_position = spawn_position
	velocity = Vector2.ZERO

func _input(event):
	# Press R to restart manually when game over
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_R):
		if current_lives <= 0:
			restart_game()

# Function to get current lives (useful for UI)
func get_current_lives() -> int:
	return current_lives

# Function to get max lives (useful for UI)
func get_max_lives() -> int:
	return max_lives
