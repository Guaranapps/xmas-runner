extends Node

#savegame filename
const SAVE_FULLFILENAME="user://data.bin"
#simple salt used to encrypt save (in order to protected file from external modification)
const PASS_SALT="e2l$HC!8ck:ExBk"

#public var to detect first launch (see stage scene)
var skip_ready=false
#private
var _score=0
var _best_score=0
signal on_score_update(score)

func _ready():
	_load()

func reset_score():
	_score=0
	emit_signal("on_score_update",_score)
	
func inc_score(value=1):
	_score+=value
	emit_signal("on_score_update",_score)

func refresh_best_score():
	if(_score>_best_score):
		_best_score=_score
		_save()

func get_score():
	return _score

func get_best_score():
	return _best_score
	
####### Save/Load
	
func _save():
	var savegame = File.new()
	#on mobile device OS.get_unique_ID() return deviceid
	#so encryption key is based on device with salt (avoid manual save corruption and other device save replacement) 
	savegame.open_encrypted_with_pass(SAVE_FULLFILENAME, File.WRITE,PASS_SALT+OS.get_unique_ID())
	savegame.store_var(_best_score)
	savegame.close()

func _load():
	var savegame = File.new()
	if savegame.file_exists(SAVE_FULLFILENAME):
		savegame.open_encrypted_with_pass(SAVE_FULLFILENAME, File.READ,PASS_SALT+OS.get_unique_ID())
		_best_score=savegame.get_var()
		savegame.close()
