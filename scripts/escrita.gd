extends Label
@onready var label = $"."

@onready var ini_texto:String = text
@onready var last_selected:int = Global.nselected
var txtposition:int=0

func _ready():
	text=""

func _process(delta):
	if Global.nselected != last_selected:
		last_selected=Global.nselected
		if text.length()<ini_texto.length()+1:
			text=ini_texto.substr(0,txtposition)
			txtposition+=1
