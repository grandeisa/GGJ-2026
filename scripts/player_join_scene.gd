extends Control

@export var join_card: PackedScene

@export var card_container: Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for prefix in PlayerManager.PREFIX_LIST:
		if Input.is_action_just_pressed("%s-item" % prefix):
			if(prefix not in PlayerManager.players_joined):
				PlayerManager.players_joined.append(prefix)
				var card = join_card.instantiate()
				card.name = prefix
				card_container.add_child(card)
