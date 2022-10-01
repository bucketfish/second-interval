extends Node2D

var seconds = 9 setget update_counter
onready var blanks = $scroll/blanks
onready var counter_label = $ui/Control/amount
onready var scroll = $scroll
var state = "play"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_counter(new):
	seconds = new
	counter_label.text = str(new)
	
	
func open_scroll():
	scroll.visible = true
	state = "scroll"
	
func finish_scroll():
	scroll.visible = false
	state = "play"
