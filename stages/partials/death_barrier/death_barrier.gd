extends Area2D

func _on_death_barrier_body_entered(body):
	if body.has_method("die") and PlayerGlobals.current_state != PlayerGlobals.STATE.DEAD:
		body.die(0)
