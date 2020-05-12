extends KinematicBody2D

const SPEED = 100
const GRAVITY = 15
const JUMP_POWER = -280
const FLOOR = Vector2(0, -1)

const FIREBALL = preload("res://bullet.tscn")

var velocity = Vector2()
var on_ground = false

var max_health = 30
onready var health = get_parent().get_parent().health

func _ready():
	self.position = self.get_parent().player_position

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$anim.play("go_right")
		velocity.x = SPEED
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$anim.play("go_right")
		velocity.x = -SPEED
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		velocity.x = 0
		if on_ground:
			$anim.play("idle")
		
		
	if Input.is_action_just_pressed("ui_up") and on_ground:
		$anim.play("jump")
		$Sprite.frame = 5
		velocity.y = JUMP_POWER
		on_ground = false
	
	if Input.is_action_just_pressed("ui_accept"):
		$anim.play("attack")
		var fireball = FIREBALL.instance()
		fireball.set_bullet_direction($Position2D.position.x)
		get_parent().add_child(fireball)
		print($Position2D.global_position)
		fireball.position = $Position2D.global_position
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		
	velocity = move_and_slide(velocity, FLOOR)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if "TYPE" in collision.collider:
				if collision.collider.TYPE == "enemy":
					self.position.x -= 20
					sub_health(1)


func restore_health():
	if get_parent().get_parent().health < max_health:
		get_parent().get_parent().health += 1
		return false
	return true
	
func sub_health(dmg):
	velocity.x = -SPEED
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1
	velocity = move_and_slide(velocity, FLOOR)
	if get_parent().get_parent().health - dmg > 0:
		get_parent().get_parent().health -= dmg

