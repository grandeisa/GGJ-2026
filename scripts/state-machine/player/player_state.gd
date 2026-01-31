class_name PlayerState
extends Node

signal state_transition(from: PlayerState, to: StringName)

var player: Player

func _enter_state() -> void: pass
func _update_state(_delta: float) -> void: pass
func _physics_update_state(_delta: float) -> void: pass
func _exit_state() -> void: pass
