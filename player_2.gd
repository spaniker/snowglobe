extends CharacterBody2D

var snowball_count = 0

func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = input_direction * 400
	move_and_slide()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("snowball") and not $HeldSnowball.visible:
		area.queue_free()
		$HeldSnowball.visible = true
	
	if area.is_in_group("basket"):
		$HeldSnowball.visible = false
		snowball_count += 1
		$CanvasLayer/SnowballCountDisplay.text= "snowball count: " + str(snowball_count)
		
