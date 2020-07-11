extends KinematicBody2D
class_name Player

const TYPE: String = "player"
const pg: PlayerGlobals = PlayerGlobals
const FIREBALL: PackedScene = preload("res://Player/bullet/bullet.tscn")
const P: PackedScene = preload("res://particles/doubleJump/doubleJumpParticles.tscn")



func _ready():
	self.position = self.get_parent().player_position

func _physics_process(delta):
	if pg.current_state != pg.STATE.DEAD:
		# Recover from knockback
		if pg.current_state == pg.STATE.KNOCKBACK and pg.velocity.y == 0:
			pg.current_state = pg.STATE.IDLE
			
		if !pg.is_wall_sliding:
			if pg.stamina < pg.MAX_STAMINA:
				pg.stamina += 1
		
		# Check for player input
		if pg.current_state != pg.STATE.KNOCKBACK:
			if Input.is_action_just_pressed("ui_up"):
				if pg.is_wall_sliding and pg.stamina - pg.wall_jump_stamina_cost > 0:
					wall_jump()
				elif pg.on_ground or can_double_jump():
					jump()
			if Input.is_action_pressed("ui_right"):
				go_right()
			elif Input.is_action_pressed("ui_left"):
				go_left()
			else:
				idle()

			if Input.is_action_just_released("restart"):
				die(0)		
			elif Input.is_action_just_pressed("ui_accept"):
				fire_bullet()

		# Check if the character is on the floor
		if is_on_floor():
			pg.is_wall_sliding = false
			pg.already_jumped = false
			pg.on_ground = true
			if pg.velocity.x == 0:
				pg.current_state = pg.STATE.IDLE
		else:
			pg.on_ground = false

		if is_on_wall() and sign(pg.velocity.y) == 1 and pg.stamina > 0:
			print(pg.velocity)
			pg.is_wall_sliding = true
			pg.stamina -= 2
			pg.velocity = pg.WALL_GRAVITY * delta
		else:
			pg.velocity += pg.GRAVITY * delta
			
		# Move the character
		pg.velocity = move_and_slide(pg.velocity, pg.FLOOR)


func restore_health():
	if pg.health < pg.max_health:
		pg.health += 1
		return false
	return true
	
func sub_health(dmg):
	if !pg.is_invincible:
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
	pg.is_invincible = true
	# Start invincibility timer
	$Timer.start(2)
	pg.current_state = pg.STATE.KNOCKBACK
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1
	if sign($Position2D.position.x) == -1:
		$Position2D.position.x *= -1
	if $Sprite.flip_h:
		pg.velocity.x = 80
	else:
		pg.velocity.x = -80
	pg.velocity.y = pg.JUMP_POWER / 2
	pg.velocity = move_and_slide(pg.velocity, pg.FLOOR)
	self.modulate.a = 0.5

func can_double_jump():
	return pg.double_jump_enabled && !pg.already_jumped

# When the invincibility timer timeouts, make player vulnerable again
func _on_Timer_timeout():
	pg.is_invincible = false
	$CollisionShape2D.disabled = false
	self.modulate.a = 1.0


func _on_deadTimer_timeout():
	get_tree().reload_current_scene()
	pg.reload_player()

# Input handling
func jump():
	var p = P.instance()
	p.position = self.position
	p.emitting = true
	get_parent().add_child(p)
	pg.on_ground = false
	$anim.play("jump")
	$Sprite.frame = 5
	pg.velocity.y = pg.JUMP_POWER
	pg.already_jumped = true

func wall_jump():
	pg.already_jumped = true
	pg.stamina -= pg.wall_jump_stamina_cost
	if $Sprite.flip_h:
		pg.velocity.x = 100
	else:
		pg.velocity.x = -100
	pg.velocity.y = pg.JUMP_POWER
	pg.velocity = move_and_slide(pg.velocity, pg.FLOOR)
	
func idle():
	pg.velocity.x = 0
	if pg.on_ground:
		$anim.play("idle")

func go_left():
	if !pg.is_wall_sliding:
		pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = true
	$anim.play("go_right")
	pg.velocity.x = -pg.SPEED
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1

func go_right():
	if !pg.is_wall_sliding:
		pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = false
	$anim.play("go_right")
	pg.velocity.x = pg.SPEED
	if sign($Position2D.position.x) == -1:
		$Position2D.position.x *= -1

func fire_bullet():
	$anim.play("attack")
	var fireball = FIREBALL.instance()
	fireball.set_bullet_direction($Position2D.position.x)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
