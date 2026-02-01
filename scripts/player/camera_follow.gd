class_name CameraFollow
extends Node3D

const SPEED = 10

var target: Node3D = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.lerp(target.position, delta * SPEED)
