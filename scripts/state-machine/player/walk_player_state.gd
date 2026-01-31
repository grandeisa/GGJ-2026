extends PlayerState
### WALK

const TURN_SPEED = 150.0

@export var throw_force : Vector3 = Vector3(0, 200, 400)

var player_rotation = 0

var item: Throwable

func _update_state(_delta: float) -> void:
	if player.input.is_action_just_pressed("bash"):
		state_transition.emit(self, "bash")
	
	if player.input.is_action_just_pressed("item"):
		if not item:
			for body in player.item_area.get_overlapping_bodies():
				if body is Throwable:
					item = body
					body.get_parent().remove_child(item)
					break
		else:
			item.global_position = player.item_origin.global_position
			item.rotation = player.item_origin.global_rotation
			get_tree().current_scene.add_child(item)
			item.apply_force(throw_force.rotated(Vector3.UP, player.rotation.y))
			
			item = null

func _physics_update_state(delta: float) -> void:
	var move_direction: Vector2 = player.input.get_vector("left", "right", "up", "down")
	
	if move_direction:
		if move_direction.length() > 1.0:
			move_direction = move_direction.normalized()
		if move_direction.is_normalized():
			player.direction = move_direction
		var angle_to_move_direction = Vector2.UP.angle_to(Vector2(move_direction.x, -move_direction.y))
		#var dir = Vector3.ZERO.look_at(Vector3(move_direction.x,0,move_direction.y))
		#player_rotation = lerp_angle(player_rotation, angle_to_move_direction, TURN_SPEED * delta)
		player_rotation = angle_to_move_direction
		var move_velocity = move_direction * Player.SPEED
		player.velocity = Vector3(move_velocity.x, player.velocity.y, move_velocity.y)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, Player.SPEED)
		
	player.rotation.y = player_rotation

	player.move_and_slide()
