extends Node3D

const PLAYER_DISTANCE: float = 1

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for prefix in PlayerManager.players_joined:
		var player: Player = player_scene.instantiate()
		player.global_position = global_position + (Vector3.FORWARD * PLAYER_DISTANCE).rotated(Vector3.UP, randf_range(0, PI * 2))
		player.ready.connect(func():
			player.input.input_prefix = prefix
			)
		
		get_tree().current_scene.add_child.call_deferred(player)
