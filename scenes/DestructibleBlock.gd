extends RigidBody2D


func on_laser_collision(laser):
	$BlockCollisionShape2D.disabled = true
	$BlockSprite2D.hide()
	$Fragments.show()
	laser.force_raycast_update()
	if laser.is_colliding():
		laser.get_collider().apply_impulse(
			-laser.get_collision_normal() * laser.impulse_force,
			laser.get_collision_point()
		)
