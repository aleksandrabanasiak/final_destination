extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var entrance_name

var stage
func _ready():
	stage = load(target_stage).instance()


func _on_SceneChanger_body_entered(body):
	if "Player" in body.name:
		get_parent().get_parent().active_scene = stage.name
		get_parent().get_parent().add_child(stage)
		get_parent().queue_free()
		#get_tree().change_scene(target_stage)
