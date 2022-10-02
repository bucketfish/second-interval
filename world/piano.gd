extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var base = get_node("/root/base")
var taken = false

onready var anim = $AnimationPlayer
onready var block = $StaticBody2D/


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && taken == false && base.of >= 10:
		base.open_scroll()
		taken = true
		block.queue_free()
	
	elif body.is_in_group("player") && taken == false && base.of < 10:
		anim.play("show")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") && taken == false && base.of < 10:
		anim.play_backwards("show")
