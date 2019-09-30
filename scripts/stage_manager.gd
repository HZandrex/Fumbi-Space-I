extends CanvasLayer

const STAGE_GAME = "res://stages/game_stage.tscn"
const STAGE_MENU = "res://stages/menu_stage.tscn"
const STAGE_STATS = "res://stages/statics_stage.tscn"

var is_changed = false

signal stage_changed

func _ready():
	pass

func change_stage(stage_path):
	if is_changed: return
	
	is_changed = true
	get_tree().get_root().set_disable_input(true)
	
	# fade to black
	self.layer = 5
	$anim.play("fade_in")
	audio_manager.get_node("audio_player_swooshing").play()
	yield($anim, "animation_finished")
	
	# change stage
	get_tree().change_scene(stage_path)
	emit_signal("stage_changed")
	
	# fade from black
	$anim.play("fade_out")
	yield($anim, "animation_finished")
	self.layer = 1
	
	is_changed = false
	get_tree().get_root().set_disable_input(false)
	pass