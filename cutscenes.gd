extends CanvasLayer

signal keypress
onready var beginanim = $beginanim
onready var endanim = $endanim
onready var base = get_node("/root/base")

var cur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$end.visible = false
	


func open_cutscene():
	visible = true
	$menu.visible = true
	beginanim.play("start")
	yield(self, "keypress")
	
	base.fade.play("fade")
	yield(base.fade, "animation_finished")
	$menu.visible = false
		
	base.fade.play_backwards("fade")

	
	while cur < 5:
		beginanim.play(str(cur))
		cur += 1
		yield(get_tree().create_timer(0.1), "timeout")
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
	
	endanim.play("0")
		
	base.state = "listen"
	base.fade.play_backwards("fade")
	yield(base.fade, "animation_finished")

	
	yield(self, "keypress")
	
	cur = 1
	
	while cur < 3:
		endanim.play(str(cur))
		cur += 1
		yield(get_tree().create_timer(0.1), "timeout")
		yield(self, "keypress")
		
	if cur == 3:
		pass
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			emit_signal("keypress")
			
	if Input.is_action_just_pressed("click"):
		emit_signal("keypress")
