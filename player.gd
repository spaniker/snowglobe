extends CharacterBody2D

const SNOWBALL_SCENE = preload("res://snowball.tscn")
var snowball_count = 0
var facing_direction: Vector2 = Vector2.RIGHT
var walk_time: float = 0.0
var babyPeng = false
const BABY_SCENE = preload("res://baby_penguin.tscn")


func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
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
		if event.is_action_pressed("ui_accept"):
			if snowball_count>0:
				throwsnowball()

func throwsnowball() -> void:
	Global.snowball_thrown.emit()
	snowball_count -= 1
	update_snowball_visuals()
	var snowball = SNOWBALL_SCENE.instantiate()
	snowball.remove_from_group("snowball") 
	snowball.add_to_group("snowballsP1")
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
	if area.is_in_group("snowballsP2"):
		Global.p2_point.emit()
		if(Global.p2_points >= 5):
			print("game over")
			$gameOver.top_level = true
			$gameOver.global_position = Vector2(580,300 )
			$gameOver.visible = true
			
			velocity = Vector2(0,0)
		$redPenguin.visible = true
		$Heart.visible = false
		await get_tree().create_timer(1).timeout
		$redPenguin.visible = false
	if area.is_in_group("penguins"):
		$Timer.start()
		$Heart.visible = true


func _on_timer_timeout() -> void:
	make_baby()
	print("baby")

func make_baby()-> void:
	var baby = BABY_SCENE.instantiate()
	baby.position = Vector2(randf_range(0,1200), randf_range(-50,500))
	get_tree().current_scene.add_child(baby)
	


func _on_pickup_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("penguins"):
		$Timer.stop()
		$Heart.visible = true
