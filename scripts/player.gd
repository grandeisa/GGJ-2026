extends CharacterBody2D


const SPEED = 300.0

var direction: Vector2 = Vector2.UP



func _physics_process(delta: float) -> void:
	var move_direction: Vector2 = Input.get_vector("p-left", "p-right", "p-up", "p-down")
	
	if move_direction:
		if move_direction.length() == 1.0:
			direction = move_direction
		velocity = move_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
