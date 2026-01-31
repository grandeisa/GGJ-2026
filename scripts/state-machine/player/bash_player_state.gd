extends PlayerState
### BASH
# This state is activated when while walking the key is pressed
# The player then launches themselves toward their walking direction pushing any objects 
# (including players and NPCs) on their way

var timer: Timer
var direction: Vector2 = Vector2.ZERO


func _enter_state() -> void:
	direction = player.direction.normalized()
	if not timer:
		timer = Timer.new()
		timer.autostart = false
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
	timer.start(player.bash_duration)

func _physics_update_state(_delta: float) -> void:
	player.velocity = Vector3(direction.x, 0, direction.y) * player.bash_velocity
	
	player.move_and_slide()

func _on_timer_timeout():
	state_transition.emit(self, "walk")
