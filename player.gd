extends KinematicBody2D


#establish scene name for saving
export var scene_id = "player"

onready var raycasts = {
	"floor":[$"raycasts/1", $"raycasts/2", $"raycasts/3"]
	}
onready var sprite = $AnimatedSprite
#constants and stuff / physics
export (int) var speed = 400
export (int) var gravity = 2800
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.2
export (float, 0, 1.0) var jumpheight = 240
export (float, 0, 1.0) var jumpinc = 0.64
export (float, 0, 1.0) var jgravity = 300
#setting up ground variables
var velocity = Vector2.ZERO
var curforce = jumpheight
var dialogue = false
var state = "idle"
var touching = false
onready var base = get_node("/root/base")

onready var coyote = $coyote
var wasonfloor = true

#onready var jumpsound = $AudioStreamPlayer
func _ready():
	#turn on things, set the base
	pass
	
func get_input(delta):
	
	#if we don't want to take input, don't take input
	if base.state != "play":
		velocity.x = 0
		velocity.y = 0
		return
		
		
	#settle these variables first
	var onfloor = raycast("floor")
	
	if (onfloor) && !touching:
		touching = true
		#jumpsound.play()
		
	#direction of player
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	
	#sideways speed, and/or friction
	if dir != 0:
		if state == "idle":
			set_state("walk")
		velocity.x = lerp(velocity.x, dir * speed, acceleration * delta * 70)
	else:
		if state == "walk":
			set_state("idle")
		velocity.x = lerp(velocity.x, 0, friction * delta * 70)
	if dir == -1:
		sprite.flip_h = true
	elif dir == 1:
		sprite.flip_h = false
		
	#apply gravity when finished jumping
	if Input.is_action_just_released("jump"):	
		if state == "jumping":
			velocity.y += jgravity
			set_state("falling")
			
		if onfloor:
			set_state("idle")
			
	
	if Input.is_action_just_pressed("jump"):
		if onfloor && state != "jumping":
			set_state("jumping")
			
		
	if Input.is_action_pressed("jump"):
		if onfloor:
			set_state("jumping")
		if state == "jumping":
			velocity.y = clamp(velocity.y - curforce, -1000, 10000000)
			curforce *= jumpinc
		
		if velocity.y >= 0:
			set_state("falling")
		
	
	#moving down in water
	
	#reseting values when hitting floor
	if onfloor:
		curforce = jumpheight
		
	velocity.y = clamp(velocity.y + gravity * delta, -1000, 1000)
	
func _physics_process(delta):
	get_input(delta)
	var snap = Vector2.DOWN if state != "jumping" else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP )
	
func raycast(area):
	for i in raycasts[area]:
		if i.is_colliding():
			return true
	return false
	
func set_state(new):
	state = new
