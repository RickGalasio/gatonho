extends Node2D
@onready var player: CharacterBody2D = $"/root/world/fase/Gatonho"

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(str(area.name)+" ID:"+str(area.owner))
	if area.name=="area_gatonho": player.reset()
