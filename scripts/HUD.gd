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
	#txtposition=7 # avoid the [right]
	#text.text=""
	#ini_texto="[right]"+txt
	dialog_box.show()
	#player_booble.hide()
	#friend_booble.show()
	#var friend_attr=portait[friend_name]
	#friend_sprite.texture=load(friend_attr["res"])
	#friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )
	
	Global.dialogs.append_array(["friend",ini_texto,friend_name])
	
func set_dialog_player(txt:String, friend_name:String) -> void:
	#Global.input_enable=Global.input_status["dialog"]
	Global.dialog_end=false
	Global.set_input_status("dialog")
	#txtposition=6 # avoid the [left]
	#text.text=""
	#ini_texto="[left]"+txt
	dialog_box.show()
	#player_booble.show()
	#friend_booble.hide()
	#var friend_attr=portait[friend_name]
	#friend_sprite.texture=load(friend_attr["res"])
	#friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )
	Global.dialogs.append_array(["player",ini_texto,friend_name])

func _process(delta:float) -> void:
	
	if dialog_box.visible:
		txt_time-=delta
		if txt_time<=0.0: 
			txt_time=MAX_TXT_TIME

			print("dialog_idx:"+str(Global.dialog_idx))
			var act_dilogs = Global.dialogs[Global.dialog_idx]
			print("z:"+str(act_dilogs))
			var itxt = act_dilogs[1]
			
			if txtposition<ini_texto.length()+1:
	
				#Portait friend
				print("y:"+str(Global.dialogs[2]))
				var friend_attr=portait[Global.dialogs[2]]
				friend_sprite.texture=load(friend_attr["res"])
				friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )
				print("X:"+str(Global.dialogs[0][0]))
				if Global.dialogs[0][0]=="player":
					txtposition=6 # avoid the [left]
					text.text=""
					#ini_texto="[left]"+txt
					#dialog_box.show()
					player_booble.show()
					friend_booble.hide()
				else:
					txtposition=7 # avoid the [right]
					text.text=""
					#ini_texto="[right]"+txt
					#dialog_box.show()
					player_booble.hide()
					friend_booble.show()
					text.text=Global.dialogs[0][1]
					#text.text=ini_texto.substr(0,txtposition)
				txtposition+=1
			#else:
				#if Global.dialog_idx+1<Global.dialogs.size():
					#Global.dialog_idx+=1
