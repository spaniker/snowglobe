extends CharacterBody2D

const SNOWBALL_SCENE = preload("res://snowball.tscn")
var snowball_count = 0
var facing_direction: Vector2 = Vector2.RIGHT

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	if input_direction != Vector2.ZERO:
		facing_direction = input_direction.normalized()
		if input_direction.x != 0:
			$Sprite2D.flip_h = input_direction.x < 0
	
	velocity = input_direction*400
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("ui_accept"):
			if snowball_count>0:
				throwsnowball()

func throwsnowball() -> void:
	snowball_count -= 1
	update_snowball_visuals()
	var snowball = SNOWBALL_SCENE.instantiate()
	snowball.remove_from_group("snowball") 
	var throw_dir = (get_global_mouse_position() - global_position).normalized()
	snowball.global_position = global_position + (throw_dir * 60.0)
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
	
