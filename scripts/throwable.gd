class_name Throwable
extends RigidBody3D

@export var on_range_outline_color: Color

@onready var area: Area3D = $Area3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var default_outline_color: Color

var on_range: bool = false

func _ready() -> void:
	mesh.material_overlay = mesh.material_overlay.duplicate()
	default_outline_color = mesh.material_overlay.get('shader_parameter/color')

func _process(delta: float) -> void:
	detect_range()
	if self.on_range:
		mesh.material_overlay.set('shader_parameter/color', Color.WHITE)
	else:
		mesh.material_overlay.set('shader_parameter/color', default_outline_color)
	
func detect_range() -> void:
	for node in area.get_overlapping_bodies():
		if node is Player:
			self.on_range = true
			return
	self.on_range = false
