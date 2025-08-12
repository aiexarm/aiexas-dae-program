extends Area2D

# QuickSandBag - Kills player on contact and triggers respawn
class_name QuickSandBag

@export var kill_delay := 0.5  # Time before killing player after contact
@export var visual_warning := true  # Show visual warning when player touches

var player_in_quicksand := false
var kill_timer: Timer

# TCP variables
var client := StreamPeerTCP.new()
var buffer := ""

func _ready():
	# Quicksand setup
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	kill_timer = Timer.new()
	kill_timer.wait_time = kill_delay
	kill_timer.one_shot = true
	kill_timer.timeout.connect(_kill_player)
	add_child(kill_timer)
	
	add_to_group("quicksand")
	print("QuickSand bag ready at position: ", global_position)

	# TCP setup
	var err = client.connect_to_host("127.0.0.1", 12345)
	if err == OK:
		print("Connected to Arduino stream")
	else:
		print("TCP connection failed with error code:", err)

func _process(delta):
	if client.get_available_bytes() > 0:
		var bytes = client.get_available_bytes()
		var data_chunk = client.get_utf8_string(bytes)
		print("Data chunk received:", data_chunk)  # DEBUG print
		
		buffer += data_chunk
		var lines = buffer.split("\n")
		for line in lines:
			var direction = line.strip_edges()
			if direction != "":
				print("Sending to _handle_input:", direction)  # DEBUG print
				_handle_input(direction)
		buffer = ""

# Quicksand signals
func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered quicksand!")
		player_in_quicksand = true
		kill_timer.start()
		if visual_warning:
			_start_warning_effect()

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player escaped quicksand!")
		player_in_quicksand = false
		kill_timer.stop()
		if visual_warning:
			_stop_warning_effect()

func _kill_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		print("QuickSand kills player!")
		if player.has_method("die"):
			player.die()
		player_in_quicksand = false
		_stop_warning_effect()

func _start_warning_effect():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate", Color(1, 0.5, 0.5, 1), 0.2)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.2)

func _stop_warning_effect():
	var tweens = get_tree().get_nodes_in_group("tween")
	for tween in tweens:
		if tween.is_valid():
			tween.kill()
	modulate = Color(1, 1, 1, 1)

# TCP input handler
func _handle_input(data: String):
	match data:
		"UP":
			get_tree().call_group("player", "move_up")
		"DOWN":
			get_tree().call_group("player", "move_down")
		"LEFT":
			get_tree().call_group("player", "move_left")
		"RIGHT":
			get_tree().call_group("player", "move_right")
		_:
			print("Unknown input:", data)
