extends Control

const prefix_text: Dictionary[StringName, String] = {
	"t1": "WASD: Movement,\n 'E': Pick/Throw",
	"t2": "Arrows: Movement,\n 'L': Pick/Throw",
	"j": "Left Analog / D-Pad: Movement,\n 'A/Cross': Pick/Throw"
}

@export var join_card: PackedScene
@export var card_container: Container
@export var next_scene: StringName

@onready var start_label: Label = $StartLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.players_joined = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for prefix in PlayerManager.PREFIX_LIST:
		if Input.is_action_just_pressed("%s-item" % prefix):
			if prefix not in PlayerManager.players_joined:
				PlayerManager.players_joined.append(prefix)
				var card = join_card.instantiate()
				var text: Label = card.get_child(0)
				card.name = prefix
				if prefix.contains('j'):
					text.text = str(len(PlayerManager.players_joined)) + ":\n" + prefix_text['j']
				else:
					text.text = str(len(PlayerManager.players_joined)) + ":\n" + prefix_text[prefix]
				
				card_container.add_child(card)
			
	if Input.is_action_just_pressed("ui_accept") and len(PlayerManager.players_joined) >= 2:
		get_tree().change_scene_to_file(next_scene)
	
	start_label.visible = len(PlayerManager.players_joined) >= 2
	
