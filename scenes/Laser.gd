extends RayCast2D

@export var root: Node2D
@export var player_body: Area2D
@export var player_aim: Node2D
@export var offscreen_multiplier = 10

@onready var line = $Line2D
@onready var collision_particles = $GPUParticles2D

var is_casting = false
var impulse_force = 10

func _ready():
	root.connect("player_shoot", self.shoot)

func _physics_process(_delta: float) -> void:
	if not is_casting: return
	position = player_body.position
	target_position = (player_aim.position - position) * offscreen_multiplier
	force_raycast_update()
	if is_colliding():
		target_position = to_local(get_collision_point())
	line.points[1] = target_position
	collision_particles.position = target_position

func shoot() -> void:
	is_casting = true
	collision_particles.emitting = true
	line.show()
	if is_colliding() and get_collider() is RigidBody2D:
		get_collider().apply_impulse(
			-get_collision_normal() * impulse_force,
			get_collision_point()
		)
	await get_tree().create_timer(0.1).timeout
	collision_particles.emitting = false
	line.hide()
	await get_tree().create_timer(0.3).timeout # cooldown
