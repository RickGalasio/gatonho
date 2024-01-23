extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(str(area.name)+" ID:"+str(area.owner))
	if area.name=="area_gatonho":
		Global.death=true
