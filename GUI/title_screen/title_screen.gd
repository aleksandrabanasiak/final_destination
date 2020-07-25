extends Control

var game_scene = "res://stages/stage_1/stage1.tscn"


func _on_startBtn_pressed():
	var hm = load(game_scene).instance()
	get_parent().add_child(hm)
	queue_free()


func _on_quitBtn_pressed():
	get_tree().quit()
