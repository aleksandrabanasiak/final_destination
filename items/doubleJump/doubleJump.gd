extends Area2D

func _on_doubleJump_body_entered(body):
	if "Player" in body.name:
		PlayerGlobals.double_jump_enabled = true
		queue_free()
		
