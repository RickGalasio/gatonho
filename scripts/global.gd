extends Node
@onready var dialog_box: NinePatchRect = $/root/world/HUD/screen/dialog_box
var input_status = {
	"dialog": 0,
	"plataform": 1,
	"death": 2,
	"dialog pause": 3,
}
var input_enable:int=input_status["plataform"]
var death:bool=false

# Dialogos
var dialog_end:bool=false
var dialogs:Array
var dialog_idx:int=0
var txtposition:int=0

var portait = {
		"tricao": {"res":"res://img/trico.png", "x":0, "y":0, "w":16, "h":16},
		"ratoncio": {"res":"res://img/trico.png", "x":0, "y":0, "w":16, "h":16},
	}

func set_input_status(status:String)->void:
	input_enable=input_status[status]
	if input_enable == 0:
		dialog_box.hide()
	else:
		dialog_box.show()

func get_input_status() -> int: return input_enable
