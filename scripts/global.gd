extends Node
@onready var dialog_box: NinePatchRect = $/root/world/HUD/screen/dialog_box
var input_status_name = {
	"dialog": 0,
	"platform": 1,
	"death": 2,
	"dialog pause": 3,
}

var game_status:int=input_status_name["platform"]
var death:bool=false

# Dialogos
var dialog_end:bool=false
var dialogs:Array
var dialog_idx:int=0
var txtposition:int=0

var dialog_koguh:bool=true

func set_input_status(status:String)->void:
	game_status=input_status_name[status]
	if game_status == input_status_name["platform"]:
		dialog_box.hide()
	else:
		dialog_box.show()

func get_input_status() -> int: return game_status
