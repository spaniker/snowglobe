extends CharacterBody2D

const SNOWBALL_SCENE = preload("res://snowball.tscn")
var snowball_count = 0
var facing_direction: Vector2 = Vector2.RIGHT
var walk_time: float = 0.0
var p1_points = 0

func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	if input_direction != Vector2.ZERO:
		if input_direction.x != 0:
			facing_direction = Vector2(sign(input_direction.x), 0)
			$Sprite2D.flip_h = input_direction.x < 0
			$redPenguin.flip_h = input_direction.x < 0
			$Heart.flip_h = input_direction.x < 0
	
	velocity = input_direction*400
	move_and_slide()
	if input_direction != Vector2.ZERO:
		walk_time += delta * 15.0 
		$Sprite2D.rotation = sin(walk_time) * 0.15 
		$Sprite2D.position.y = -abs(sin(walk_time)) * 8.0
		
		$Heart.rotation = sin(walk_time) * 0.15 
		$Heart.position.y = -abs(sin(walk_time)) * 8.0
		
		$redPenguin.rotation = sin(walk_time) * 0.15 
		$redPenguin.position.y = -abs(sin(walk_time)) * 8.0

func _unhandled_input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("throw"):
			if snowball_count>0:
				throwsnowball()

func throwsnowball() -> void:
	snowball_count -= 1
	Global.snowball_thrown.emit()
	update_snowball_visuals()
	var snowball = SNOWBALL_SCENE.instantiate()
	snowball.remove_from_group("snowball") 
	snowball.add_to_group("snowballsP2")
	var throw_dir = (get_global_mouse_position() - global_position).normalized()
	snowball.global_position = global_position + Vector2(-400,-340)
	snowball.direction = facing_direction
	get_tree().current_scene.add_child(snowball)
	

func update_snowball_visuals() -> void:
	$SnowballOne.visible = (snowball_count == 1)
	$SnowballTwo.visible = (snowball_count == 2)
	$SnowballThree.visible = (snowball_count == 3)

func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("snowball"):
		area.queue_free()
		snowball_count += 1
		update_snowball_visuals()
	if area.is_in_group("snowballsP1"):
		Global.p1_point.emit()
		if(Global.p1_points >= 5):
			print("game over")
			$gameOver.top_level = true
			$gameOver.global_position = Vector2(580,320 )
			$gameOver.visible = true
			velocity = Vector2(0,0)
		
		$redPenguin.visible = true
		$Heart.visible = false
		await get_tree().create_timer(1).timeout
		$redPenguin.visible = false
	if area.is_in_group("penguins"):
		$Heart.visible = true
