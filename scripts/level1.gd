extends TileMap
@onready var gatonho: CharacterBody2D = $"../Gatonho"
@onready var level_1: TileMap = $"."
@onready var spike:= preload("res://scenes/spike.tscn")
@onready var player:= preload("res://scenes/gatonho.tscn")
@onready var gaveta: Timer = $gaveta
@onready var trico: Node2D = $trico
@onready var hud: CanvasLayer = get_node("/root/world/HUD")

var ispike
var iplayer

func _ready() -> void:
	gaveta.wait_time==0.3
	gaveta.start()
	await level_1.draw # Await draw the tiles
	#print("=========================\\")
	#for x in range(0.0,200.0):
		#for y in range(0.0,200.0):
			#if level_1.get_cell_source_id(0,Vector2(float(x),float(y)))!=-1:
				#print("Tile(%2.2f):" % x)
	#print("=========================/")
	for i in get_used_cells_by_id(0,1):
		#print("Tile["+str(i))
		ispike = spike.instantiate()
		ispike.position = map_to_local(i)
	#	get_parent().call_deferred("add_child",ienemy)
		get_parent().add_child(ispike)
		set_cell(0,i,-1) # Apaga o tile

	for i in get_used_cells_by_id(0,3):
		iplayer = player.instantiate()
		iplayer.position = map_to_local(i)
	#	get_parent().call_deferred("add_child",ienemy)
		get_parent().add_child(iplayer)
		set_cell(0,i,-1)

func _process(delta: float) -> void:
	#if gatonho.global_position.x>trico.global_position.x:
		#trico.trico_flip(true)
	#else:
		#trico.trico_flip(false)
	pass

func _on_gaveta_timeout() -> void:
	#print("Atualiza gaveta")
	pass

func dialogo_deprimido(area: Area2D) -> void:
	hud.set_dialog_friend("Não chega perto Gatoncio!\nEu já decidi...","ratoncio")

	hud.set_dialog_player("Não é Gatôncio, é Gatonho!","ratoncio")

