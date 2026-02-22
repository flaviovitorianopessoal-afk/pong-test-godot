extends Node2D
var screen_size
var speed = 100
var isBallRunning = false
var direction

func centerBall():
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2

func random_pong_direction():
	var angle = randf_range(-0.5, 0.5)
	var side = [-1, 1].pick_random()
	var d = Vector2(side, angle)
	return d.normalized()

func _ready() -> void:
	screen_size = get_viewport_rect().size
	centerBall()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		direction = random_pong_direction()
		isBallRunning = true
	if isBallRunning:
		position += direction * speed * delta
