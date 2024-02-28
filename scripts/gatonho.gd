extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var remote: RemoteTransform2D = $remote_camera
@onready var camera: Camera2D = $"../../Camera2D"
@onready var info: RichTextLabel = $info
@onready var glider_bar: Sprite2D = $glider_bar
@onready var text: RichTextLabel = $"../../HUD/screen/dialog_box/text"
@onready var dialog_box: NinePatchRect = $"../../HUD/screen/dialog_box"
@onready var init_pos:Vector2=Vector2.ZERO

const SPEED:float= 6000.0
const JUMP_VELOCITY:float= -300.0
const COYOTE_VEL_MAX:float= 179.0
const DASH:float=0.2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count:int=0
var max_jumps:int=1
var max_dashs:int=1

var direction:float
var velmax:float=500.0

var dash_time:float=0.0
var dash_count:int=0

var glider_frame:int=0
var disable_glider=false
var GLIDER_BAR_FRAMES:int=0

var last_vel:float=123.0
var jump_buffer:float=0.0
var swin:bool=false

#==========================================================
func reset() -> void:
	#await get_tree().create_timer(2.0).timeout
	info.hide()
	anim.play("idle")
	Global.death=false
	position=init_pos+Vector2(0,-1)

#==========================================================
func set_death() -> void: Global.death=true

#==========================================================
func set_swin() -> void:
	swin=true
	anim.play("swin")

#==========================================================
func _ready() -> void:
	GLIDER_BAR_FRAMES=44
	info.show()
	glider_bar.show()
	glider_bar.region_rect=Rect2(0,0,32,8)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	# Set the camera
	remote.remote_path=camera.get_path()
	
#==========================================================
func input_player(delta:float)->void:
	# Player Input ======================================================
	if Input.is_key_pressed(KEY_ESCAPE): get_tree().quit()
	if Input.is_action_just_released("F11"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_released("reset"): reset()
	
	if Global.get_input_status()==Global.input_status_name["platform"]:
		if anim.get("animation") != "fall":
			if Input.is_action_just_pressed("dash") and not is_on_floor() and dash_count<max_dashs:
				dash_time=DASH
			if Input.is_action_just_released("dash"):
				dash_count+=1
			dash_time-=delta
			if dash_time<=0: dash_time=0
			if Input.is_action_just_pressed("ui_accept"):
				jump_buffer=0.1
			jump_buffer-=delta
			if jump_buffer<0: jump_buffer=0
			
			if jump_buffer>0 and velocity.y<COYOTE_VEL_MAX and velocity.y>=0.0 and jump_count < max_jumps:
				velocity.y = JUMP_VELOCITY	
				
			if Input.is_action_just_released("ui_accept") and !is_on_floor():
				jump_count+=1
				velocity.y *= 0.5
				
			if Input.is_action_just_pressed("ui_down"): position.y=position.y+1
			
			direction = Input.get_axis("ui_left", "ui_right")
	elif Global.get_input_status()==Global.input_status_name["dialog"]:
		direction=0.0
	elif Global.get_input_status()==Global.input_status_name["dialog pause"]:
		direction=0.0
		if Input.is_action_just_pressed("ui_accept"):

			if Global.dialog_idx>=Global.dialogs.size():
				Global.dialog_idx=0
				Global.set_input_status("platform")
				Global.dialogs.clear()
				dialog_box.hide()
			else:
				print("TAMANHO DIALOGS:"+str(Global.dialogs.size()))
				print("Global.dialog_idx:"+str(Global.dialog_idx))
				#if Global.dialogs.size()+1<Global.dialog_idx:
				Global.dialog_idx+=1
				text.text=""
				print("XX:"+str(Global.get_input_status()))
				Global.set_input_status("dialog")
				#Global.dialog_idx+=1
				Global.txtposition=0
		direction = 0
		velocity = Vector2i.ZERO

#==========================================================
func _physics_process(delta) -> void:
	input_player(delta)
	# movment ====================================
 	# Velocidade terminal
	if last_vel>velmax and velocity.y==0: set_death()

	# Save CheckPoint
	if velocity==Vector2.ZERO and not Global.death: init_pos=position
	
	# Hide instructions
	if velocity.x!=0 and not Global.death: info.hide()
		
	if direction: 
		velocity.x = direction * SPEED * delta
		if direction>0:
			anim.flip_h=false
		if direction<0:
			anim.flip_h=true
	else:
		velocity.x = 0 

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
		if Input.is_action_pressed("glider") and velocity.y>0 and not disable_glider:
			glider_bar.show()
			glider_frame+=1
			glider_bar.region_rect=Rect2(32*glider_frame,0,32,8)
			if glider_frame>GLIDER_BAR_FRAMES:
				disable_glider=true
				glider_frame=0
			Global.death=false
			velocity.y = (gravity * delta)/8
			if anim.flip_h:
				velocity.x=-1*SPEED*delta
			else:
				velocity.x=SPEED*delta
	if Input.is_action_just_released("glider"):
		glider_frame=0
		glider_bar.hide()
		anim.play("idle")
		
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		glider_frame=0
		glider_bar.region_rect=Rect2(0,0,32,8)
		glider_bar.show()
		dash_count=0
		disable_glider=false

# Animation ======================================================
	if is_on_floor():
		jump_count=0
		if Global.death:
			anim.play("fall")
			info.show()
			velocity=Vector2i.ZERO
		else:
			if direction==0:
				anim.play("idle")
			else:
				anim.play("walk")
	else: #not is_on_floor()
		if glider_frame>0:
			anim.play("glider")
		else:
			anim.play("idle")
	last_vel=velocity.y
	move_and_slide()

func _on_area_gatonho_body_entered(body: Node2D) -> void:
	#print("Body:"+str(body.get_index(true)))
	pass
	
