extends KinematicBody2D

const TYPE = "player"
const pg = PlayerGlobals
const FIREBALL = preload("res://Player/bullet/bullet.tscn")
const P = preload("res://particles/doubleJump/doubleJumpParticles.tscn")

var velocity = Vector2.ZERO
var on_ground = false
var is_invincible = false

func _ready():
	self.position = self.get_parent().player_position

func _physics_process(delta):
	if pg.current_state != pg.STATE.DEAD:
		# Recover from knockback
		if pg.current_state == pg.STATE.KNOCKBACK and velocity.y == 0:
			pg.current_state = pg.STATE.IDLE
		
		# Check for player input
		if pg.current_state != pg.STATE.KNOCKBACK:
			if Input.is_action_just_pressed("ui_up") and (on_ground or can_double_jump()):
				jump()

			if Input.is_action_pressed("ui_right"):
				go_right()
			elif Input.is_action_pressed("ui_left"):
				go_left()
			elif Input.is_action_just_released("restart"):
				die(0)		
			elif Input.is_action_just_pressed("ui_accept"):
				fire_bullet()
			else:
				idle()
		
		# Check if the character is on the floor
		if is_on_floor():
			pg.already_jumped = false
			on_ground = true
		else:
			on_ground = false

		# Move the character
		velocity += pg.GRAVITY * delta
		velocity = move_and_slide(velocity, pg.FLOOR)




func restore_health():
	if pg.health < pg.max_health:
		pg.health += 1
		return false
	return true
	
func sub_health(dmg):
	if !is_invincible:
		knockback()
		if pg.health - dmg >= 0:
			pg.health -= dmg
		else:
			die(2)
		
func die(timeout):
	pg.current_state = pg.STATE.DEAD
	$anim.play("die")
	$deadTimer.start(timeout)
	
func knockback():
	is_invincible = true
	# Start invincibility timer
	$Timer.start(2)
	pg.current_state = pg.STATE.KNOCKBACK
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1
	if sign($Position2D.position.x) == -1:
		$Position2D.position.x *= -1
	if $Sprite.flip_h:
		velocity.x = 80
	else:
		velocity.x = -80
	velocity.y = pg.JUMP_POWER / 2
	velocity = move_and_slide(velocity, pg.FLOOR)
	self.modulate.a = 0.5

func can_double_jump():
	return pg.double_jump_enabled && !pg.already_jumped

# When the invincibility timer timeouts, make player vulnerable again
func _on_Timer_timeout():
	is_invincible = false
	$CollisionShape2D.disabled = false
	self.modulate.a = 1.0


func _on_deadTimer_timeout():
	get_tree().reload_current_scene()
	pg.reload_player()
	pg.can_double_jump()

# Input handling
func jump():
	var p = P.instance()
	p.position = self.position
	p.emitting = true
	self.get_parent().add_child(p)
	pg.already_jumped = true
	$anim.play("jump")
	$Sprite.frame = 5
	velocity.y = pg.JUMP_POWER
	on_ground = false

func idle():
	velocity.x = 0
	if on_ground:
		$anim.play("idle")

func go_left():
	pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = true
	$anim.play("go_right")
	velocity.x = -pg.SPEED
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1

func go_right():
	pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = false
	$anim.play("go_right")
	velocity.x = pg.SPEED
	if sign($Position2D.position.x) == -1:
		$Position2D.position.x *= -1

func fire_bullet():
	$anim.play("attack")
	var fireball = FIREBALL.instance()
	fireball.set_bullet_direction($Position2D.position.x)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
