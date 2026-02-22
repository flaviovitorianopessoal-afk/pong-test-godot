extends Node2D

# Variables
@export var speed = 400
var screen_size
var isMaxup = false
var isMaxdown = false

func _ready() -> void:
	# Get viewport size and stores on a variable ( screen_size ).
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	# Player movement.
	var velocity = Vector2.ZERO
	# Adds a fixed value to the velocity variable while key is pressed.
	# If the variables ( isMaxup and isMaxdown ) are true, the velocity wil not be changed.
	if Input.is_action_pressed("move_up") and not isMaxup:
		velocity.y += -1
	if Input.is_action_pressed("move_down") and not isMaxdown:
		velocity.y += 1
		
	# Normalizes velocity and multiplies by speed variable.
	velocity = velocity.normalized() * speed
	# Adds velocity * delta to player position.
	position += velocity * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Detect collision on walls ( Up and Down).
	# Set the variables that restrict the player movement to true.
	if body.name == "UpWall":
		isMaxup = true
	if body.name == "DownWall":
		isMaxdown = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	# Detects when the player stop colliding with the walls
	# Set the variables that restrict the player movement to false.
	isMaxdown = false
	isMaxup = false
