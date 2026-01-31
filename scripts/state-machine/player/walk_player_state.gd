extends PlayerState
### WALK

func _update_state(_delta: float) -> void:
	if Input.is_action_just_pressed("p-bash"):
		state_transition.emit(self, "bash")

func _physics_update_state(delta: float) -> void:
	var move_direction: Vector2 = Input.get_vector("p-left", "p-right", "p-up", "p-down")
	
	if move_direction:
		if move_direction.length() > 1.0:
			move_direction = move_direction.normalized()
		
		if move_direction.is_normalized():
			player.direction = move_direction
		player.velocity = move_direction * Player.SPEED
		if player.direction.x != 0:
			player.sprite.flip_h = player.direction.x < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Player.SPEED)
		player.velocity.y = move_toward(player.velocity.y, 0, Player.SPEED)

	player.move_and_slide()
