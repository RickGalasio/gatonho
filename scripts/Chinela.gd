extends Sprite2D
var y_direction:float=-10
var chinela_y_ini:float
var chinela_y_end:float

@onready var chinela: Sprite2D = $"."
@onready var iten_detail: NinePatchRect = $/root/world/HUD/screen/iten_detail

var flute = 0.1 as float
var i:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flute=0.5

func _process(delta: float) -> void:
	i+=1
	chinela.position.y+=flute
	if i > 15.0:
		flute=flute*-1
		i=0
		
func _on_area_2d_chinela_body_entered(body: Node2D) -> void:
	iten_detail.show()
	chinela.queue_free()
	
