extends Node2D

var player_position = Vector2(50, 120)
var entrance_entered = "NULL"

func _ready():
	if entrance_entered == "right":
		player_position = Vector2(700,50)
	else:
		player_position = Vector2(50, 120)
