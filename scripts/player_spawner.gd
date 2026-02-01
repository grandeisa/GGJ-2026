extends Node3D

const PLAYER_DISTANCE: Vector3 = Vector3.RIGHT * 2

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var origin_offset = Vector3.ZERO
	for prefix in PlayerManager.players_joined:
		var player: Player = player_scene.instantiate()
		player.global_position = global_position + origin_offset
		player.ready.connect(func():
			player.input.input_prefix = prefix
			)
		
		get_tree().current_scene.add_child.call_deferred(player)
		origin_offset += PLAYER_DISTANCE
