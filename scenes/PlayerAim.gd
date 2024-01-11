extends Node2D

func move(direction_vector, tile_size):
	var target_vector = direction_vector * tile_size
	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "position", position + target_vector, 0.1)
