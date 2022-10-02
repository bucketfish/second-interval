extends CanvasLayer

signal keypress
onready var beginanim = $beginanim
onready var endanim = $endanim
onready var base = get_node("/root/base")

var cur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$end.visible = false
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
		beginanim.stop()
		
		base.state = "play"
		base.fade.play_backwards("fade")
		
	
func end_cutscene():
	base.fade.play("fade")
	yield(base.fade, "animation_finished")
	visible = true
		
	base.state = "listen"
	base.fade.play_backwards("fade")
	yield(base.fade, "animation_finished")

	
	cur = 0
	
	while cur < 3:
		endanim.play(str(cur))
		cur += 1
		yield(self, "keypress")
		
	if cur == 3:
		pass
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			emit_signal("keypress")
			
	if Input.is_action_just_pressed("click"):
		emit_signal("keypress")
