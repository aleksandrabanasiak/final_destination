extends Node2D

const mg = MainGlobals

func _process(_delta):
	if mg.previous_scene != mg.active_scene:
		mg.previous_scene = mg.active_scene



func _on_TitleMenu_tree_exited():
	$CanvasLayer/GUI.visible = true
