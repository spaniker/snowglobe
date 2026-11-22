extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO # Defaults to ZERO so snowballs on the ground stay still!

func _process(delta: float) -> void:
	position += direction * speed * delta
