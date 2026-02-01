class_name Player
extends CharacterBody3D

const SPEED = 10.0
const MAX_PICKUP_PITCH_DISTANCE = 0.05


var coin_count = 0

@export var bash_velocity = 40.0
@export var bash_duration = 1.0

@onready var input: PlayerInput = $PlayerInput
@onready var item_area: Area3D = $ItemArea3D
@onready var item_origin: Node3D = $ItemOrigin
@onready var model_animator: AnimationPlayer = $Model/AnimationPlayer
@onready var pickup_audio: AudioStreamPlayer = $PickupAudio

var direction: Vector2 = Vector2.UP

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	for node in item_area.get_overlapping_bodies():
		if node.is_in_group("coin"):
			coin_count += 1
			node.queue_free()
			pickup_audio.pitch_scale = 1 + randf_range(-MAX_PICKUP_PITCH_DISTANCE, MAX_PICKUP_PITCH_DISTANCE)
			pickup_audio.play()
			
