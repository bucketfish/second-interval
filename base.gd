extends Node2D

var seconds = 9 setget update_counter
onready var blanks = $scroll/blanks
onready var counter_label = $ui/Control/amount
onready var scroll = $scroll
onready var pianoaudio = $pianoaudio
var state = "play"

var curpiano = -1

var audios = [preload("res://audio/part1.wav"), preload("res://audio/part2.wav"), preload("res://audio/part3.wav"), preload("res://audio/part4.wav"), preload("res://audio/part5.wav")]

onready var particles = $scroll/Particles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("a"):
		update_counter(10)

func update_counter(new):
	seconds = new
	counter_label.text = str(new)
	
	
func open_scroll():
	scroll.visible = true
	state = "scroll"
	curpiano += 1
	
func finish_scroll():
	state = "listen"
	pianoaudio.stream = audios[curpiano]
	pianoaudio.play()
	
	yield(pianoaudio, "finished")
	scroll.visible = false
	particles.visible = false
	state = "play"
