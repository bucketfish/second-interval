extends Node2D

var seconds = 0 setget update_counter
var of = 0
onready var blanks = $scroll/blanks
onready var counter_label = $ui/Control/amount
onready var scroll = $scroll
onready var pianoaudio = $pianoaudio
var state = "play"

onready var ofamount = $ui/Control/of
onready var ofparticle = $ui/Control/Particle
onready var player = $player
onready var startpos = $startpos

onready var audiotween = $audiotween
onready var backaudio = $back
onready var fade = $fade/fade

var curpiano = -1

var audios = [preload("res://audio/part1.wav"), preload("res://audio/part2.wav"), preload("res://audio/part3.wav"), preload("res://audio/part4.wav"), preload("res://audio/part5.wav")]

var colors = ["#ff8484", "#fee086", "#c4ffb6", "#4887ff", "#986eff"]

onready var particles = $scroll/Particles2D
onready var endingaudio = $ending

onready var cutscenes = $cutscenes
# Called when the node enters the scene tree for the first time.
func _ready():
	ofparticle.modulate = colors[curpiano + 1]
	player.global_position = startpos.global_position
	cutscenes.open_cutscene()
	state = "listen"
	

func _input(event):
	if Input.is_action_pressed("a"):
		update_counter(10)
		update_of(10)
		player.global_position.x += 500

func update_counter(new):
	seconds = new
	counter_label.text = str(new)
	update_of(of + 1)
	
func update_of(val):
	ofamount.text = str(val) + "/10 of"
	of = val
	
func open_scroll():
	scroll.visible = true
	state = "scroll"
	curpiano += 1
	audiotween.interpolate_property(backaudio, "volume_db", -7, -50, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	audiotween.start()
	yield(audiotween, "tween_completed")
	backaudio.playing = false
	
func finish_scroll():
	state = "listen"
	pianoaudio.stream = audios[curpiano]
	pianoaudio.play()
	
	yield(pianoaudio, "finished")
	if curpiano == 4:
		endingaudio.play()
		cutscenes.end_cutscene()
	else:
		scroll.visible = false
		particles.visible = false
		state = "play"
		of = 0
		update_of(0)
		ofparticle.modulate = colors[curpiano + 1]
		backaudio.playing = true
		audiotween.interpolate_property(backaudio, "volume_db", -50, -7, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		audiotween.start()

