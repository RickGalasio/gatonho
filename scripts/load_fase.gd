extends Node2D
@onready var level:int=2
@onready var gatonho: CharacterBody2D = %Gatonho

func _ready() -> void:
	var bfase = load("res://scenes/level_"+str(level)+".tscn").instantiate()
	bfase.z_index=-1 # Draw before player
	add_child(bfase) 
	
