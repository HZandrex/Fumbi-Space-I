extends Node

const GROUP_PIPES   = "pipes"
const GROUP_GROUNDS = "grounds"
const GROUP_BIRDS   = "birds"

const MEDAL_BRONZE = 10
const MEDAL_SILVER = 20
const MEDAL_GOLD   = 30
const MEDAL_PLATINUM = 40

var score_best       = 0 setget _set_score_best
var score_current    = 0 setget _set_score_current
var attempts         = 0
var playtime_total   = 0 
var playtime_current = 0 

signal score_best_changed
signal score_current_changed

func _ready():
	stage_manager.connect("stage_changed", self, "_on_stage_changed")
	load_game()
	pass

func _on_stage_changed():
	score_current = 0
	pass

func _set_score_best(new_value):
	attempts += 1
	playtime_total += playtime_current
	if new_value > score_best:
		score_best = new_value
		emit_signal("score_best_changed")
	
	save_game()
	pass

func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
	pass

func load_game():
	#save_game()
	var save_game = File.new()
	if not save_game.file_exists("user://savedata.bin"):
	    return # Error! We don't have a save to load.
	
	save_game.open_encrypted_with_pass("user://savedata.bin", File.READ, OS.get_unique_id())
	var loaded_data = {}
	loaded_data = parse_json(save_game.get_as_text())
	score_best = loaded_data.score_best
	attempts = loaded_data.attempts
	playtime_total = loaded_data.playtime_total
	save_game.close()
	pass
    
func save_game():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://savedata.bin", File.WRITE, OS.get_unique_id())
	save_game.store_line(to_json({
		"score_best" : score_best,
		"attempts" : attempts,
		"playtime_total" : playtime_total
		}))
	save_game.close()
	pass