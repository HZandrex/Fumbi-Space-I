extends Camera2D

onready var bird = utils.get_main_node().get_node("bird")

func _ready():
	pass

func _process(delta):
	position = Vector2(bird.position.x, position.y)
	pass

func get_total_pos():
	return position + get_offset()
	pass