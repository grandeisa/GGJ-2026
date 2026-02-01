extends PlayerState

const DURATION: float = 2.0

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start(DURATION)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update_state(_delta: float) -> void:
	player.model_animator.play("fall")

func _on_timer_timeout() -> void:
	state_transition.emit(self, "timeout")
