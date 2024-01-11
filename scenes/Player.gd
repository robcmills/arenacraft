extends Node2D

@export var root: Node2D
@export var player_aim: Node2D

func _ready():
	root.connect("player_shoot", self.shoot)

func move(direction_vector, tile_size):
	var target_vector = direction_vector * tile_size
	$RayCast2D.target_position = target_vector
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		var move_tween = get_tree().create_tween()
		move_tween.tween_property(self, "position", position + target_vector, 0.1)

func shoot():
	$ShootSprite2D.show()
	await get_tree().create_timer(0.1).timeout
	$ShootSprite2D.hide()
	$ShootSpriteCooldown.show()
	$ShootSpriteCooldown.rotation = get_angle_to(player_aim.position)
	$ShootSpriteCooldown.play()

func _on_shoot_sprite_cooldown_animation_finished():
	$ShootSpriteCooldown.hide()
