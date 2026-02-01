extends Control

@onready var result_label: Label = $ResultLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ordered_coin_count = PlayerManager.player_coin_count.duplicate()
	ordered_coin_count.sort()
	var winner_index: int = PlayerManager.player_coin_count.find(ordered_coin_count[-1])
	var result_text = ""
	
	for i in range(len(PlayerManager.players_joined)):
		result_text += "Player %d: $%d " % [i+1, PlayerManager.player_coin_count[i]]
		if i == winner_index:
			result_text += "< WINNER >"
		result_text += "\n"
	
	result_label.text = result_text
