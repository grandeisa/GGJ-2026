class_name PlayerStateMachine
extends Node

var states: Dictionary[StringName, PlayerState] = {}
@export var current_state: PlayerState
var player: Player

func _ready() -> void:
	player = get_parent()
	
	for child:PlayerState in get_children():
		states[child.name.to_lower()] = child
		child.state_transition.connect(_on_state_transition)
		child.player = player
	
	current_state._enter_state()

func _process(delta: float) -> void:
	current_state._update_state(delta)
	
func _physics_process(delta: float) -> void:
	current_state._physics_update_state(delta)

func _on_state_transition(from: PlayerState, to: StringName):
	if(from != current_state or to.to_lower() not in states.keys()):
		return
	
	from._exit_state()
	current_state = states[to.to_lower()]
	current_state._enter_state()
