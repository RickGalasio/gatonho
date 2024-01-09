extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var gatonho = $"."
@onready var remote: RemoteTransform2D = $remote_camera
@onready var camera: Camera2D = $"../../Camera2D"

const SPEED = 6000.0
const JUMP_VELOCITY = -300.0
const COYOTE_VEL_MAX = 179.666656494141
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_jumps:int=1

var direction:float
var death:bool=false
var velmax:float=500.0
var jump_count:int=0

var last_vel:float=123.0
var jump_buffer:float=0.0
@onready var init_pos:Vector2=gatonho.position

#==========================================================
func reset() -> void:
	#anim.play("hurt")
	#await anim.animation_finished
	#await get_tree().create_timer(2.0).timeout
	anim.play("idle")
	death=false
	gatonho.position=init_pos
#==========================================================
func _ready() -> void:
	# Set the camera
	remote.remote_path=camera.get_path()

#==========================================================
func player_input(delta) -> void:
	if Input.is_key_pressed(KEY_ESCAPE): get_tree().quit()
	if Input.is_action_just_released("F11"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_released("reset"): reset()

	if anim.get("animation") != "fall":
		if Input.is_action_just_pressed("ui_accept"): 
			jump_buffer=0.1
		jump_buffer-=delta
		if jump_buffer>0 and velocity.y<COYOTE_VEL_MAX and jump_count<max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count+=1 
		if Input.is_action_just_released("ui_accept") and !is_on_floor():
			velocity.y *= 0.5
		direction = Input.get_axis("ui_left", "ui_right")
#==========================================================
func _physics_process(delta) -> void:
	if last_vel>velmax and velocity.y==0:
			#print("Velocidade terminal")
			death=true
	if velocity==Vector2(0,0) and not death:
		init_pos=position
		
	if direction:
		velocity.x = direction * SPEED * delta

		if direction>0:
			anim.flip_h=false
		if direction<0:
			anim.flip_h=true
	else:
		velocity.x = 0 #move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		velocity.y += gravity * delta
		#print("vel:"+str(velocity.y))

	if is_on_floor():
		jump_count=0
		if death:
			anim.play("fall")
	
	player_input(delta)

	if anim.get("animation") != "fall":
		if direction!=0 and is_on_floor():
			anim.play("walk")
		else:
			anim.play("idle")
	last_vel=velocity.y
	move_and_slide()
