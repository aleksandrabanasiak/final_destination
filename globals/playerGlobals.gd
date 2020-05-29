extends Node2D

# Player health-related stuff
var max_health = 3
var health = 3

# Movement-related values
const SPEED = 100
const GRAVITY = Vector2(0, 1200)
const JUMP_POWER = -380
const FLOOR = Vector2(0, -1)

# Sprites
const player_sprite = preload("res://Player/assets/player.png")

# Player states
enum STATE{ IDLE, KNOCKBACK, JUMP, MOVING, DEAD }
var current_state = STATE.IDLE

# Double jump flag
var double_jump_enabled = false
var already_jumped = false


func reload_player():
	health = max_health
	current_state = STATE.IDLE
