extends Node

@onready var dialog_box: NinePatchRect = $/root/world/HUD/screen/dialog_box

var input_status = {
	"dialog": 0,
	"plataform": 1,
	"death": 2,
}
var input_enable:int=1
var death:bool=false
var dialog_end:bool=true
var gamestate=["menu","pause","dialog","fase","bossfight"]
var portait = {
		"tricao": {"res":"res://img/trico.png", "x":0, "y":0, "w":16, "h":16},
		"ratoncio": {"res":"res://img/trico.png", "x":0, "y":0, "w":16, "h":16},
		"": "",
	}
func set_input_status(status:String)->void:
	input_enable=input_status[status]
	if input_enable == 0:
		dialog_box.hide()
	else:
		dialog_box.hide()
	
	

func get_input_status() -> int:
	return input_enable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Global")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
