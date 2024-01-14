extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var remote: RemoteTransform2D = $remote_camera
@onready var camera: Camera2D = $"../../Camera2D"
@onready var info: RichTextLabel = $info
@onready var glider_bar: Sprite2D = $glider_bar

const SPEED = 6000.0
const JUMP_VELOCITY = -300.0
const COYOTE_VEL_MAX = 179.666656494141
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_jumps:int=1
var max_dashs:int=1

var direction:float
var death:bool=false
var velmax:float=500.0
var jump_count:int=0

const DASH:float=0.2
var dash_time:float=0.0
var dash_count:int=0

var is_glider:bool=false
var glider_timer:int=0
var disable_glider=false

var last_vel:float=123.0
var jump_buffer:float=0.0
@onready var init_pos:Vector2=position

#==========================================================
func reset() -> void:
	#await get_tree().create_timer(2.0).timeout
	info.hide()
	anim.play("idle")
	death=false
	position=init_pos+Vector2(0,-1)
#==========================================================
func set_death() -> void:
	death=true
	
#==========================================================
func _ready() -> void:
	info.show()
	glider_bar.show()
	glider_bar.region_rect=Rect2(0,0,32,8)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	# Set the camera
	remote.remote_path=camera.get_path()

#==========================================================
func _physics_process(delta) -> void:
	# Velocidade terminal
	if last_vel>velmax and velocity.y==0: set_death()

	# Save CheckPoint
	if velocity==Vector2.ZERO and not death: init_pos=position
	
	# Hide instructions
	if velocity.x!=0 and not death: info.hide()
		
	if direction: 
		velocity.x = direction * SPEED * delta
		if direction>0:
			anim.flip_h=false
		if direction<0:
			anim.flip_h=true
	else:
		velocity.x = 0 
		#velocity.x = move_toward(velocity.x, 0, SPEED) # 
	
	if dash_time>0 and dash_count<max_dashs:
		if anim.flip_h:
			velocity.x = SPEED * delta * -3
		else:
			velocity.x = SPEED * delta * 3
		if Input.is_action_pressed("ui_up"):
			velocity.y=SPEED * delta*-1
		else:
			velocity.y=lerp(velocity.y,0.0,1)
	else:
		if Input.is_action_pressed("ui_up") and velocity.y>0 and not disable_glider:
			#print("GLIDER")
			is_glider=true
			glider_bar.show()
			glider_timer+=1
			glider_bar.region_rect=Rect2(32*glider_timer,0,32,8)
			if glider_timer>44:
				disable_glider=true
				glider_timer=0
			
			death=false
			velocity.y = (gravity * delta)/8
			if anim.flip_h:
				velocity.x=-1*SPEED*delta
			else:
				velocity.x=SPEED*delta
	if Input.is_action_just_released("ui_up"):
		is_glider=false
		glider_bar.hide()
		anim.play("idle")
		
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		glider_timer=0
		is_glider=false
		glider_bar.region_rect=Rect2(0,0,32,8)
		glider_bar.show()
		dash_count=0
		disable_glider=false
		#print("vel:"+str(velocity.y))
		
	# Player Input ======================================================
	if Input.is_key_pressed(KEY_ESCAPE): get_tree().quit()
	if Input.is_action_just_released("F11"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_released("reset"): reset()
	
	if anim.get("animation") != "fall":
		if Input.is_action_just_pressed("dash") and not is_on_floor():
			#print("dash")
			dash_time=DASH
		dash_time-=delta
		if dash_time<=0: dash_time=0
			
		if Input.is_action_just_pressed("ui_accept"): 
			jump_count+=1
			jump_buffer=0.1
		jump_buffer-=delta
		if jump_buffer>0 and velocity.y<COYOTE_VEL_MAX and jump_count<max_jumps:
			print("---")
			print("jump_count:%2d" % jump_count)
			velocity.y = JUMP_VELOCITY
			
		if Input.is_action_just_released("ui_accept") and !is_on_floor():
			velocity.y *= 0.5
		direction = Input.get_axis("ui_left", "ui_right")
		if Input.is_action_just_pressed("ui_down"): position.y=position.y+1

# Animation ======================================================		
	if is_glider:
		anim.play("glider")
		
	if is_on_floor():
		jump_count=0
		if death:
			anim.play("fall")
			info.show()
			velocity=Vector2i.ZERO
			#position=Vector2.ZERO

		if anim.get("animation") != "fall":
			if direction!=0 and is_on_floor():
				anim.play("walk")
			else:
				anim.play("idle")
	last_vel=velocity.y	
	move_and_slide()

func _on_area_gatonho_body_entered(body: Node2D) -> void:
	#print("Body:"+str(body.name))
	pass
