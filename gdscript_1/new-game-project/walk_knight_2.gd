extends CharacterBody2D

@export var speed := 200

func _physics_process(_delta):
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

# Optional: Add collision detection
func _on_body_entered(body):
	if body.has_method("collect"):
		body.collect()

# Optional: Add animation support
func _update_animation(direction: Vector2):
	# You can add sprite animation logic here
	# For example, if you have an AnimationPlayer node:
	# if direction.length() > 0:
	#     $AnimationPlayer.play("walk")
	# else:
	#     $AnimationPlayer.play("idle")
	pass
