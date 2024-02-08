extends CanvasLayer
@onready var dialog_box: NinePatchRect = $screen/dialog_box
@onready var lives: HBoxContainer = $screen/lives
@onready var text: RichTextLabel = $screen/dialog_box/text

@onready var friend_sprite: Sprite2D = $screen/dialog_box/friend/friend_sprite
@onready var player_sprite: Sprite2D = $screen/dialog_box/player/player_sprite

@onready var player_booble: Sprite2D = $screen/dialog_box/player/player_booble
@onready var friend_booble: Sprite2D = $screen/dialog_box/friend/friend_booble

var portait = {
		"tricao": {"res":"res://img/trico.png", "x":0, "y":0, "w":16, "h":16},
		"ratoncio": {"res":"res://img/Ratôncio.png", "x":0, "y":0, "w":16, "h":16},
		"": "",
	}

var ini_texto:String = ""
var txtposition:int=0
const MAX_TXT_TIME:float = 0.01
var txt_time:float=MAX_TXT_TIME

func set_dialog_friend(txt:String, friend_name:String) -> void:
	#Global.input_enable=Global.input_status["dialog"]
	Global.dialog_end=false
	Global.set_input_status("dialog")
	dialog_box.show()
	Global.dialogs.append(["friend",txt,friend_name])
	
func set_dialog_player(txt:String, friend_name:String) -> void:
	#Global.input_enable=Global.input_status["dialog"]
	Global.dialog_end=false
	Global.set_input_status("dialog")
	dialog_box.show()
	Global.dialogs.append(["player",txt,friend_name])

func _process(delta:float) -> void:
	if dialog_box.visible:
		txt_time-=delta
		if txt_time<=0.0: 
			txt_time=MAX_TXT_TIME
			if txtposition<Global.dialogs[Global.dialog_idx][1].length()+1:
				#Portait friend
				var friend_attr=portait[Global.dialogs[Global.dialog_idx][2]]
				friend_sprite.texture=load(friend_attr["res"])
				friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )
				
				if Global.dialogs[Global.dialog_idx][0]=="player":
					player_booble.show()
					friend_booble.hide()
					#text.text=""
					text.text="[left]"+Global.dialogs[Global.dialog_idx][1].substr(0,txtposition)
					
				elif Global.dialogs[Global.dialog_idx][0]=="friend":
					player_booble.hide()
					friend_booble.show()
					#text.text=""
					text.text="[right]"+Global.dialogs[Global.dialog_idx][1].substr(0,txtposition)
					
				txtposition+=1
