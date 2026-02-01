extends Node3D

@export var max_time: float = 30.0
@export var time_label: Label
@export var level_end_scene_path: StringName
@export var spawner: PlayerSpawner

var level_timer: Timer

func _ready() -> void:
	level_timer = Timer.new()
	level_timer.timeout.connect(_on_level_timer_end)
	add_child(level_timer)
	level_timer.start(max_time)

func _process(_delta: float) -> void:
	update_time_text()
	
func update_time_text() -> void:
	var time_left = level_timer.time_left
	var seconds: float = fmod(time_left, 60.0)
	var minutes: int = (time_left - seconds) / 60
	
	time_label.text = "%02d:%04.1f" % [minutes, seconds]

func _on_level_timer_end() -> void:
	PlayerManager.player_coin_count = []
	for player in spawner.players:
		PlayerManager.player_coin_count.append(player.coin_count)
	
	get_tree().change_scene_to_file(level_end_scene_path)
