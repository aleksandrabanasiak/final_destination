extends Area2D

const mg = MainGlobals

export(String, FILE, "*.tscn") var target_stage
export(String) var entrance_name

var stage
var root
var current_level

func _ready():
	stage = load(target_stage).instance()
	root = get_parent().get_parent()
	current_level = root.get_node(get_parent().get_path())

func _on_SceneChanger_body_entered(body):
	if "Player" in body.name:
		mg.active_scene = stage.name
		
		current_level.call_deferred("free")
		root.remove_child(current_level)
		
		root.add_child(stage)
