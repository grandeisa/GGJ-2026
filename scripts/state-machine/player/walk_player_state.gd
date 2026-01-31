extends PlayerState
### WALK

func _update_state(_delta: float) -> void:
	if player.input.is_action_just_pressed("bash"):
		state_transition.emit(self, "bash")

func _physics_update_state(delta: float) -> void:
	var move_direction: Vector2 = player.input.get_vector("left", "right", "up", "down")
	
	if move_direction:
		if move_direction.length() > 1.0:
			move_direction = move_direction.normalized()
		if move_direction.is_normalized():
			player.direction = move_direction
			player.look_at(player.position - Vector3(move_direction.x, 0, move_direction.y))
		var move_velocity = move_direction * Player.SPEED
		player.velocity = Vector3(move_velocity.x, player.velocity.y, move_velocity.y)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, Player.SPEED)

	player.move_and_slide()
