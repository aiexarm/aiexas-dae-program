extends Node2D

@onready var tilemaplayer = $TileMapLayer

const ROWS = 25
const COLS = 25
const WALL = Vector2i(0, 0)
const  PATH = Vector2i(1,0)

var maze = []

func _ready() -> void:
	generate_maze()

func reset_maze():
	maze = []
	for r in range(ROWS):
		var row = []  # ✅ Initialize the row as an empty list
		for c in range(COLS):
			row.append(1)  # ✅ Fill the row with values
		maze.append(row)  # ✅ Append the completed row to the maze
	

func generate_maze():
	reset_maze()
	
	var start_row = 1
	var start_col = 1
	maze[start_row][start_col] = 0
	
	print(maze)
	
func _process(delta: float) -> void:
	pass
