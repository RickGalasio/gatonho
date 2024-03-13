extends Sprite2D
@onready var gatonho: CharacterBody2D = $"../Gatonho"
@onready var koguh: Sprite2D = $"."
@onready var hud: CanvasLayer = $"/root/world/HUD"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="Gatonho" and Global.dialog_koguh:
		hud.set_dialog_friend("Gatonho, seu danado, cuidado aí!\nVai desabar o teto do meu barraco!","koguh")
		hud.set_dialog_player("Desculpa Koguh!\nTô sem chinela e o asfalto tá mó quente!","koguh")
		hud.set_dialog_friend("Ué, desce aí no meu quintal e pega aquela chinela lá pra você, seu doidão.","koguh")
		Global.dialog_koguh=false
	pass
	 # Replace with function body.
