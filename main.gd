extends Node2D

signal player_shoot

@onready var tile_size = $TileMap.tile_set.tile_size.x
var inputs = {
	"player_aim_down": func(): $PlayerAim.move(Vector2.DOWN, tile_size),
	"player_aim_left": func(): $PlayerAim.move(Vector2.LEFT, tile_size),
	"player_aim_right": func(): $PlayerAim.move(Vector2.RIGHT, tile_size),
	"player_aim_up": func(): $PlayerAim.move(Vector2.UP, tile_size),
	"player_move_down": func(): $PlayerBody.move(Vector2.DOWN, tile_size),
	"player_move_left": func(): $PlayerBody.move(Vector2.LEFT, tile_size),
	"player_move_right": func(): $PlayerBody.move(Vector2.RIGHT, tile_size),
	"player_move_up": func(): $PlayerBody.move(Vector2.UP, tile_size),
	"player_shoot": func(): player_shoot.emit(),
}

func _unhandled_input(event):
	for action in inputs.keys():
		if event.is_action_pressed(action):
			inputs[action].call()
