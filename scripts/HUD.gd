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

#func _ready() -> void:
	#print("region:"+str(player_sprite.region_rect))
	#pass

func set_dialog_friend(txt:String, friend_name:String) -> void:
	#Global.input_enable=Global.input_status["dialog"]
	Global.set_input_status("dialog")
	text.text="[right]"+txt
	dialog_box.show()
	player_booble.hide()
	friend_booble.show()
	var friend_attr=portait[friend_name]
	friend_sprite.texture=load(friend_attr["res"])
	friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )
	
func set_dialog_player(txt:String, friend_name:String) -> void:
	#Global.input_enable=Global.input_status["dialog"]
	Global.set_input_status("dialog")
	text.text="[left]"+txt
	dialog_box.show()
	player_booble.show()
	friend_booble.hide()
	var friend_attr=portait[friend_name]
	friend_sprite.texture=friend_attr["res"]
	friend_sprite.region_rect=Rect2(Vector2(friend_attr["x"], friend_attr["y"]), Vector2(friend_attr["w"], friend_attr["h"]) )

#func _process(delta: float) -> void:
	#pass
