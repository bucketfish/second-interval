extends Control

var notevals = [0, 2, 4, 2, 0, -1, -3, -5, 0, 2, 0, 2, 4, 2, 0, 7, 9, 7, 5, 4, 2, -1, 0]

var notepos =  [0, 1, 2, 1, 0, -1, -2, -3, 0, 1, 0, 1, 2, 1, 0, 4, 5, 4, 3, 2, 1, -1, 0]

var toput = preload("res://scroll/toput.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 23):
		var curput = toput.instance()
		curput.note_num = i
		curput.note_val = notepos[i]
		curput.position.x = 220 + 33 * i
		curput.position.y = 346 - 38 * curput.note_val
		curput.name = "note" + str(i)
		add_child(curput)
	
	get_node("note0").can_put = true

func _on_toput_put_note(note_num):
	print(note_num)
	if note_num < 23:
		get_node("note" + str(note_num + 1)).can_put = true
