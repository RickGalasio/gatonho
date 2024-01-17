extends TileMap
@onready var gatonho: CharacterBody2D = $"../Gatonho"
@onready var level_1: TileMap = $"."
@onready var spike:= preload("res://scenes/spike.tscn")
@onready var gaveta: Timer = $gaveta
@onready var trico: Node2D = $trico

var ispike
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
	#			get_parent().call_deferred("add_child",ienemy)
		get_parent().add_child(ispike)
		set_cell(0,i,-1) # Apaga o tile

func _process(delta: float) -> void:
	if gatonho.global_position.x>trico.global_position.x:
		trico.trico_flip(true)
	else:
		trico.trico_flip(false)
	


func _on_gaveta_timeout() -> void:
	pass # Replace with function body.
