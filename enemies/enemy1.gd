extends KinematicBody2D

const TYPE = "enemy"
const SPEED = 15
const GRAVITY = 15
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

var hp = 3
var velocity = Vector2()
var direction = 1 

var is_dead = false

func _ready():
	pass
	
	
func dmg():
	hp -= 1
	$Sprite.texture = preload("res://assets/enemy1_dmg.png")
	yield(get_tree().create_timer(0.1),"timeout")
	$Sprite.texture = preload("res://assets/enemy1.png")
	if hp == 0:
		dead()
func dead():
	$CollisionShape2D.set_deferred("disabled", true)
	is_dead = true
	velocity = Vector2(0,0)
	
	$AnimationPlayer.play("die")
	
	yield(get_tree().create_timer(0.6),"timeout")
	queue_free()

func _physics_process(delta):
	if !is_dead:
		velocity.x = SPEED * direction
		velocity.y = GRAVITY
		$AnimationPlayer.play("go")
		velocity = move_and_slide(velocity, FLOOR)
	
		if is_on_wall() || $RayCast2D.is_colliding() == false:
			$Sprite.flip_h = !($Sprite.flip_h)
			direction *= -1
			$RayCast2D.position.x *= -1
		
