extends Node2D
@onready var trico: CharacterBody2D = $trico
@onready var coli: CollisionShape2D = $CharacterBody2D/coli
@onready var anim: AnimatedSprite2D = $CharacterBody2D/anim
@onready var player: CharacterBody2D = %Gatonho

func _physics_process(delta: float) -> void:
	#if position.x>player.position.x:
		#anim.flip_h=true
	#else:
		#anim.flip_h=false
	pass

func _ready() -> void: pass
