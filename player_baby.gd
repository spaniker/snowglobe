extends CharacterBody2D

const SNOWBALL_SCENE = preload("res://snowball.tscn")
var snowball_count = 0
var facing_direction: Vector2 = Vector2.RIGHT
var walk_time: float = 0.0

func _physics_process(delta):
	var input_direction = Input.get_vector("move_leftB", "move_rightB", "move_upB", "move_downB");
	if input_direction != Vector2.ZERO:
		if input_direction.x != 0:
			facing_direction = Vector2(sign(input_direction.x), 0)
			$babyPenguin.flip_h = input_direction.x < 0
	velocity = input_direction*400
	move_and_slide()
	
	if input_direction != Vector2.ZERO:
		walk_time += delta * 15.0 
		$babyPenguin.rotation = sin(walk_time) * 0.15 
		$babyPenguin.position.y = -abs(sin(walk_time)) * 8.0
