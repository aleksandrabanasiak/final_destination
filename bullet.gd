extends KinematicBody2D

const SPEED = 10

var velocity = Vector2()
# 1 = right, -1 = left
var direction = 1

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$anim.flip_h = true
		
	else:
		$anim.flip_h = false

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	velocity.x = SPEED * delta * direction
	translate(velocity)
	$anim.play("shoot")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
