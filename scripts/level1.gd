extends TileMap
@onready var gatonho: CharacterBody2D = $"../Gatonho"
@onready var level_1: TileMap = $"."
@onready var spike:= preload("res://scenes/spike.tscn")
@onready var player:= preload("res://scenes/gatonho.tscn")
#@onready var gaveta: Timer = $gaveta
@onready var trico: Node2D = $trico
@onready var hud: CanvasLayer = get_node("/root/world/HUD")

var ispike
var iplayer

func _ready() -> void:
	#gaveta.wait_time==0.3
	#gaveta.start()
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
	hud.set_dialog_friend("Não chega perto Gatonho!\nEu já decidi...","ratoncio")
	hud.set_dialog_player("Elas não iriam querer isso.","ratoncio")
	hud.set_dialog_friend("Elas eram a minha vida,\nnão me resta nada.","ratoncio")
	hud.set_dialog_player("Resta o amor da vida delas, resta você.","ratoncio")
	hud.set_dialog_player("A gente só morre quando esquecem da gente.","ratoncio")
	hud.set_dialog_player("Mantenha sua família viva em você.","ratoncio")
	hud.set_dialog_friend("Foi tudo culpa minha, eu que estava dirigindo.","ratoncio")
	hud.set_dialog_friend("Minha filhinha, minha mulher. Eu falhei com elas.","ratoncio")
	hud.set_dialog_player("Aquele acidente não foi de propósito.","ratoncio")
	hud.set_dialog_player("Se uma delas sobrevivesse, você iria querer\nque ela continuasse viva.","ratoncio")
	hud.set_dialog_player("Elas iriam querer o mesmo por você","ratoncio")
	hud.set_dialog_friend("Eu causei a morte delas e agora\nestou preso nessa cadeira de rodas.","ratoncio")
	hud.set_dialog_player("Você está nessa cadeira de roas.","ratoncio")
	hud.set_dialog_player("Mas você não está preso.","ratoncio")
	hud.set_dialog_player("Venha comigo e eu vou te mostrar\nque sua família continua viva em você.","ratoncio")
	hud.set_dialog_player("E vou provar que nada pode te prender.","ratoncio")
	
