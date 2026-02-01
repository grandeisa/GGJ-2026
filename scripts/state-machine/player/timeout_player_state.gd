extends PlayerState

const DURATION = 7.0

@export var time_label: Label
@export var timeout_ui: Control

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timeout_ui.visible = false

func _enter_state() -> void:
	player.entered_timeout.emit()
	player.model_animator.play("die")
	timer.start(DURATION)
	timeout_ui.visible = true

func _update_state(_delta: float) -> void:
	time_label.text = "%04.1f" % timer.time_left

func _exit_state() -> void:
	timeout_ui.visible = false
	player.exit_timeout.emit()

func _on_timer_timeout() -> void:
	state_transition.emit(self, 'walk')
