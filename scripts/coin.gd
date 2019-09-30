extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_enter")
	pass

func _on_body_enter(other_body):
	if other_body.is_in_group(game.GROUP_BIRDS):
		#increase score
		game.score_current += 1
		audio_manager.get_node("audio_player_point").play()
	pass