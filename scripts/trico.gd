extends Node2D
#@onready var trico: CharacterBody2D = $trico
@onready var trico: Sprite2D = $trico

@onready var coli: CollisionShape2D = $trico/coli
@onready var anim: AnimatedSprite2D = $trico/anim
@onready var fala: RichTextLabel = $fala
@onready var hud: CanvasLayer = $"/root/world/HUD"

func trico_flip(flip:bool)->void:
	anim.flip_h=flip
	
func _ready() -> void: 
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	hud.set_dialog_friend("Oi Gatonho!\nQuer café?","tricao")

func _on_area_2d_area_exited(area: Area2D) -> void:
	pass
	
	
