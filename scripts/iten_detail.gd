extends NinePatchRect
@onready var iten_detail: NinePatchRect = $"."
@onready var iten: Sprite2D = $iten
@onready var name_iten: RichTextLabel = $name_iten

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if iten_detail.visible:
		await get_tree().create_timer(2.0).timeout
		iten_detail.hide()
	
