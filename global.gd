extends Node2D

const SNOWBALL_SCENE = preload("res://snowball.tscn")
signal snowball_thrown()
signal p1_point()
signal p2_point()
var p1_points = 0
var p2_points = 0

func _ready() -> void:
	Global.snowball_thrown.connect(_on_snowball_thrown)



func _on_snowball_thrown()-> void:
	print("thrown")
	respawnSnowballs()

func respawnSnowballs () -> void:
	await get_tree().create_timer(2).timeout
	var snowball = SNOWBALL_SCENE.instantiate()
	snowball.add_to_group ("snowball")
	snowball.position = Vector2(randf_range(-100,800), randf_range(-100,200))
	add_child(snowball)
		
