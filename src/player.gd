extends Node2D

@export var speed = 400
var screen_size
var isMaxup = false
var isMaxdown = false

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	# Player movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up") and not isMaxup:
		velocity.y += -1
	if Input.is_action_pressed("move_down") and not isMaxdown:
		velocity.y += 1
	
	velocity = velocity.normalized() * speed	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "UpWall":
		isMaxup = true
	if body.name == "DownWall":
		isMaxdown = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	isMaxdown = false
	isMaxup = false
