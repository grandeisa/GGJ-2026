extends CharacterBody3D

const SPEED = 2.0
const TURN_SPEED = 30.0

@export var default_light_color: Color = Color.WHITE
@export var wary_light_color: Color = Color.YELLOW
@export var chase_light_color: Color = Color.RED

@onready var light: SpotLight3D = $SpotLight3D
@onready var view_area: Area3D = $Area3D
@onready var model_animator: AnimationPlayer = $Model/AnimationPlayer
@onready var player_caught_audio: AudioStreamPlayer = $PlayerCaughtAudio

var target: Node3D = null

func _process(_delta: float) -> void:
	model_animator.play("idle")
	if target:
		if target is Player:
			light.light_color = chase_light_color
		if target is Throwable:
			light.light_color = wary_light_color
	else:
		light.light_color = default_light_color

func _physics_process(delta: float) -> void:
	handle_view()
	
	if target:
		var direction = (target.position - position).normalized() * SPEED
		
		var look_pos = Vector3(target.global_position.x, global_position.y, target.global_position.z) - global_position
		var target_angle = Vector3.BACK.angle_to(look_pos)
		rotation.y = lerp_angle(rotation.y, target_angle, TURN_SPEED * delta)
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func handle_view() -> void:
	var space_state = get_world_3d().direct_space_state
	var query
	var result
	
	if target:
		query = PhysicsRayQueryParameters3D.create(global_position, target.global_position)
		result = space_state.intersect_ray(query)
		
		if result and view_area.overlaps_body(target):
			if target is Player:
				return
		else:
			target = null
		
	
	var new_target: Node3D = null
	for body in view_area.get_overlapping_bodies():
		if body is Player or body is Throwable:
			query = PhysicsRayQueryParameters3D.create(global_position, body.global_position)
			result = space_state.intersect_ray(query)
			
			if result:
				if result.collider == body:
					new_target = body
					if body is Player:
						player_caught_audio.pitch_scale = 1 + randf_range(-0.05, -0.05)
						player_caught_audio.play()
	target = new_target
		
		
		
		
