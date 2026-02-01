extends Node3D

const PLAYER_DISTANCE: float = 1

@export var player_scene: PackedScene
@export var viewport_container: Container
@export var timeout_spot: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for prefix in PlayerManager.players_joined:
		var player: Player = player_scene.instantiate()
		reset_player_position(player)
		player.ready.connect(func():
			player.input.input_prefix = prefix
			player.remove_child.call_deferred(player.viewport)
			viewport_container.add_child.call_deferred(player.viewport)
			)
		
		player.entered_timeout.connect(func() : send_player_to_timeout(player))
		player.exit_timeout.connect(func() : reset_player_position(player))
		
		get_tree().current_scene.add_child.call_deferred(player)

func send_player_to_timeout(player: Player) -> void:
	player.position = timeout_spot.position + (Vector3.FORWARD * PLAYER_DISTANCE).rotated(Vector3.UP, randf_range(0, PI * 2))

func reset_player_position(player: Player) -> void:
	player.global_position = global_position + (Vector3.FORWARD * PLAYER_DISTANCE).rotated(Vector3.UP, randf_range(0, PI * 2))
