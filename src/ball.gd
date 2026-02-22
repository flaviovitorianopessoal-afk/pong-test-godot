extends Node2D
# Variables
var screen_size
var speed = 100
var isBallRunning = false
var direction

func centerBall(): # Center ball at the center of screen.
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2

func random_pong_direction():
	# Randomizes angle and side.
	var angle = randf_range(-0.5, 0.5)
	var side = [-1, 1].pick_random()
	# Creates a Vector2 variable with both randomized values ( d ).
	var d = Vector2(side, angle)
	return d.normalized()

func _ready() -> void:
	# Get viewport size and stores on a variable ( screen_size ).
	# Calls centerBall function.
	screen_size = get_viewport_rect().size
	centerBall()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		# Starts Ball movement based on the value returned by the random_pong_direction function.
		direction = random_pong_direction()
		# Set the state of the ball to Running changing the variable ( isBallRunning ).
		isBallRunning = true
	if isBallRunning:
		# The position of the ball is the result of multiplying the variables ( direction and speed ).
		# While isBallRunning is true the ball will keep moving.
		position += direction * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Detects collisions on all walls ( Left, Right, Up and down)
	# Inverts the X direction of the ball multiplying the desired vector by -1 while keeping the speed
	# This causes a bounce effect wich can be replicated on other entities
	if body.name == "LeftWall" or body.name == "RightWall":
		direction.x = direction.x * -1
	
	if body.name == "UpWall" or body.name == "DownWall":
		direction.y = direction.y * -1
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	# Detects collision with the player
	# Inverts the X direction just like on the walls
	if area.name == "PlayerArea":
		direction.x = direction.x * -1
		# Adds a variation to the Y direction by randomizing a negative and positive value ( 0 to 1 )
		direction.y = direction.y + randf_range(-0.5, 0.5)
