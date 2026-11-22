extends CharacterBody2D

var snowball_count = 0

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	velocity = input_direction*400
	move_and_slide()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("snowball") and snowball_count == 0:
		area.queue_free()
		snowball_count +=1
		$SnowballOne.visible = true
	elif area.is_in_group("snowball") and snowball_count == 1:
		area.queue_free()
		$SnowballOne.visible = false
		$SnowballTwo.visible = true
		snowball_count +=1
	elif area.is_in_group("snowball") and snowball_count == 2:
		area.queue_free()
		$SnowballOne.visible = false
		$SnowballTwo.visible = false
		$SnowballThree.visible = true
		snowball_count +=1
	
