extends Node2D

var seconds = 0 setget update_counter
onready var blanks = $scroll/blanks
onready var counter_label = $ui/Control/amount
var state = "play"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_counter(new):
	seconds = new
	counter_label.text = str(new)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
