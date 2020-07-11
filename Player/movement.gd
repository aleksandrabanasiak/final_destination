const pg = PlayerGlobals
const P = preload("res://particles/doubleJump/doubleJumpParticles.tscn")

# Input handling
func jump(kb: KinematicBody2D):
	if pg.current_state == pg.STATE.WALL_SLIDING:
		wall_jump()
	else:
		var p = P.instance()
		p.position = self.position
		p.emitting = true
		kb.get_parent().add_child(p)
		pg.already_jumped = true
		kb.$anim.play("jump")
		$Sprite.frame = 5
		velocity.y = pg.JUMP_POWER
		on_ground = false

func idle():
	velocity.x = 0
	if on_ground:
		$anim.play("idle")

func go_left(pos):
	pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = true
	$anim.play("go_right")
	velocity.x = -pg.SPEED
	if sign($Position2D.position.x) == 1:
		pos.position.x *= -1

func go_right(pos):
	pg.current_state = pg.STATE.MOVING
	$Sprite.flip_h = false
	$anim.play("go_right")
	velocity.x = pg.SPEED
	if sign($Position2D.position.x) == -1:
		pos.position.x *= -1
		
func wall_jump():
	if sign($Position2D.position.x) == 1:
		$Position2D.position.x *= -1
	if sign($Position2D.position.x) == -1:
		$Position2D.position.x *= -1
	if $Sprite.flip_h:
		velocity.x = 100
	else:
		velocity.x = -100
	velocity.y = pg.JUMP_POWER / 2
	velocity = move_and_slide(velocity, pg.FLOOR)
