class_name Player
extends CharacterBody2D

const SPEED = 300.0

@export var bash_velocity = 600.0
@export var bash_duration = 1.0


@onready var sprite: Sprite2D = $Sprite2D

var direction: Vector2 = Vector2.UP
