extends Area2D

func _on_Heart_body_entered(body):
	if "Player" in body.name:
		var wasMax
		wasMax = body.restore_health()
		if !wasMax:
			queue_free()
		
