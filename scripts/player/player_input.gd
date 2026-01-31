class_name PlayerInput
extends Node

@export var input_prefix: StringName = "t1"

func format_action_name(action: StringName) -> StringName:
	return input_prefix + "-" + action

func get_axis(negative_action: StringName, positive_action: StringName) -> float: 
	return Input.get_axis(format_action_name(negative_action), format_action_name(positive_action))

func get_vector(negative_x: StringName, positive_x: StringName, \
	negative_y: StringName, positive_y: StringName, deadzone: float = -1.0):
		return Input.get_vector(format_action_name(negative_x), \
								format_action_name(positive_x), \
								format_action_name(negative_y), \
								format_action_name(positive_y), \
									deadzone)
									

func is_action_just_pressed(action: StringName, exact_match: bool = false) -> bool:
	return Input.is_action_just_pressed(format_action_name(action), exact_match)

func is_action_just_released(action: StringName, exact_match: bool = false) -> bool:
	return Input.is_action_just_released(format_action_name(action), exact_match)

func is_action_pressed(action: StringName, exact_match: bool = false) -> bool:
	return Input.is_action_pressed(format_action_name(action), exact_match)
