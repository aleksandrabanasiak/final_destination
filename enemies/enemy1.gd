extends Area2D

const TYPE = "enemy"
const SPEED = 15
const GRAVITY = 0.2
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

var hp = 3
var velocity = Vector2()
var direction = 1 

var is_dead = false

func _ready():
	velocity.y = GRAVITY
	
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
		$AnimationPlayer.play("go")
		
		for body in get_overlapping_bodies():
			if body.has_method("sub_health") and PlayerGlobals.current_state != PlayerGlobals.STATE.DEAD:
				body.sub_health(1)
		velocity.x = SPEED * delta * direction
		translate(velocity)

		# Change direction when on the edge of the platform
		if !$floorCast.is_colliding():
			changeDirection()
		
		# Change direction after hitting a wall
		if $wallCast.is_colliding():
			if $wallCast.get_collider().name == "TileMap":
				changeDirection()
				
func changeDirection():
	$Sprite.flip_h = !($Sprite.flip_h)
	direction *= -1
	$wallCast.position.x *= -1
	$floorCast.position.x *= -1
	
func _on_Enemy_body_entered(body):
	if body.name == "TileMap":
		velocity.y = 0
		translate(velocity)
