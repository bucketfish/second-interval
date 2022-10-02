extends Node2D


export var note_num: int
export var note_val: int
var can_put = false

onready var anim = $anim

signal put_note(note_num)

onready var blanks = get_node("/root/base/scroll/blanks")
onready var base = get_node("/root/base")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("put_note", blanks, "_on_toput_put_note")


func _on_TextureButton_pressed():
	if can_put && base.state == "scroll":
		can_put = false
		emit_signal("put_note", note_num)
		
		
func put():
	anim.play("put")
	

