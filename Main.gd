extends Node2D

var old_active_scene = "Stage1"
export(String) var active_scene = "Stage1"
onready var node = get_node(active_scene)
export(int) var health = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_active_scene != active_scene:
		node = get_node(active_scene)
		old_active_scene = active_scene
	$CanvasLayer/GUI.health = health
	#pass

