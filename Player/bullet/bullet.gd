extends Area2D

const SPEED = 10

var velocity = Vector2()
var direction = 1

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$anim.flip_h = true
		
	else:
		$anim.flip_h = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$anim.play("shoot")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_area_entered(area):
	if area.has_method("dmg"):
		area.dmg()
	queue_free()


func _on_bullet_body_entered(body):
	queue_free()
