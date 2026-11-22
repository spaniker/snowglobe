extends Label

func _ready() -> void:
	text = str(Global.p2_points) + "      "+ str(Global.p1_points)
	Global.p1_point.connect(_on_p1_change)
	Global.p2_point.connect(_on_p2_change)
	

func _on_p1_change():
	print("p2 hit")
	Global.p1_points += 1
	text =  str(Global.p2_points) + "      "+ str(Global.p1_points)

func _on_p2_change():
	Global.p2_points += 1
	text = str(Global.p2_points) + "      "+ str(Global.p1_points)
	
