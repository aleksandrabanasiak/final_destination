extends Node2D

# Player health-related stuff
var max_health: int = 3
var health: int = 3
var is_invincible: bool = false

# Movement-related values
const SPEED: int = 100
const GRAVITY: Vector2 = Vector2(0, 1200)

const JUMP_POWER: int = -380
const FLOOR: Vector2 = Vector2(0, -1)

var velocity: Vector2 = Vector2.ZERO
var on_ground: bool = false

# Wall jump
var is_wall_sliding: bool = false
const WALL_GRAVITY: Vector2 = Vector2(0, 100)
const MAX_STAMINA: int = 60
var stamina: int = 60
var wall_jump_stamina_cost: int = 15

# Sprites
const player_sprite: StreamTexture = preload("res://Player/assets/player.png")

# Player states
enum STATE{ IDLE, KNOCKBACK, JUMP, MOVING, DEAD }
var current_state: int = STATE.IDLE

# Double jump flag
var double_jump_enabled: bool = true
var already_jumped: bool = false


func reload_player():
	health = max_health
	current_state = STATE.IDLE
	double_jump_enabled = false
