class_name Player
extends CharacterBody3D

const SPEED = 10.0

@export var bash_velocity = 40.0
@export var bash_duration = 1.0

@onready var input: PlayerInput = $PlayerInput

var direction: Vector2 = Vector2.UP
