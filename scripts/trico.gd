extends Node2D
#@onready var trico: CharacterBody2D = $trico
@onready var trico: Sprite2D = $trico

@onready var coli: CollisionShape2D = $trico/coli
@onready var anim: AnimatedSprite2D = $trico/anim
@onready var fala: RichTextLabel = $fala

func trico_flip(flip:bool)->void:
	anim.flip_h=flip
	
func _ready() -> void: 
	fala.visible=false

func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.name=="gatonho":
	fala.visible=true

func _on_area_2d_area_exited(area: Area2D) -> void:
	#if area.name=="gatonho":
	fala.visible=false

