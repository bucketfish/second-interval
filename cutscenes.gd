extends CanvasLayer

signal keypress
onready var beginanim = $beginanim
onready var base = get_node("/root/base")

var cur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open_cutscene():
	visible = true
	
	while cur < 5:
		beginanim.play(str(cur))
		cur += 1
		yield(self, "keypress")
		
	if cur == 5:
		base.fade.play("fade")
		yield(base.fade, "animation_finished")
		visible = false
		
		base.state = "play"
		base.fade.play_backwards("fade")
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			emit_signal("keypress")
			
	if Input.is_action_just_pressed("click"):
		emit_signal("keypress")
