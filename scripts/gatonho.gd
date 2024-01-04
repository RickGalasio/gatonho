extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var gatonho = $"."
@onready var fall_time: Timer = $fall_time
@onready var coyote_time: Timer = $coyote_time

const SPEED = 70.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction:float
var velmax:float=0.0
#==========================================================
func _ready() -> void:
	fall_time.wait_time=0.60

#==========================================================
func player_input():
	if anim.get("animation") != "fall":
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY 
		if Input.is_action_just_released("ui_accept") and !is_on_floor():
			velocity.y *= 0.5
		direction = Input.get_axis("ui_left", "ui_right")
		
		if direction:
			velocity.x = direction * SPEED
			if direction>0:
				anim.flip_h=false
			if direction<0:
				anim.flip_h=true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
#==========================================================
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if not fall_time.is_stopped():
			fall_time.stop()
		
	if velocity.y>0 and !is_on_floor():
		if fall_time.is_stopped():
			fall_time.start()
	
	player_input()

	if anim.get("animation") != "fall":
		if direction!=0 and is_on_floor():
			anim.play("walk")
		else:
			anim.play("idle")

	move_and_slide()

func _on_fall_time_timeout() -> void:
	anim.play("fall")

