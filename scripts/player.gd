class_name Player
extends CharacterBody3D

const SPEED = 10.0

@export var bash_velocity = 40.0
@export var bash_duration = 1.0

@onready var input: PlayerInput = $PlayerInput
@onready var item_area: Area3D = $ItemArea3D
@onready var item_origin: Node3D = $ItemOrigin

var direction: Vector2 = Vector2.UP

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
