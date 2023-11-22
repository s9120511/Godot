extends MarginContainer

@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var shield_bar: ProgressBar = $HBoxContainer/ShieldBar

func update_score(value: int) -> void:
	score_label.text = "%08d" % value
	
func update_shield(max_value, value) -> void:
	shield_bar.max_value = max_value
	shield_bar.value = value
	
