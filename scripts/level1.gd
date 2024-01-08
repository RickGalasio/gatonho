extends TileMap
@onready var gatonho: CharacterBody2D = $"../Gatonho"
@onready var level_1: TileMap = $"."
@onready var spike:= preload("res://scenes/spike.tscn")

var ispike
func _ready() -> void:
	await level_1.draw # Await draw the tiles
	for x in get_used_cells(0):
		print("Cell:"+str(x))

	for i in get_used_cells_by_id(0,1):
		print("Tile")
		ispike = spike.instantiate()
		ispike.position = map_to_local(i)
	#			get_parent().call_deferred("add_child",ienemy)
		get_parent().add_child(ispike)
		set_cell(0,i,-1) # Apaga o tile

func _process(delta: float) -> void:
	pass
	
