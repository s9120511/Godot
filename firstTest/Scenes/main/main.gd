extends Node2D

var enemy_scene = preload("res://Scenes/enemy/enemy.tscn")
var score = 0

func _ready() -> void:
	spawn_all_enemies()
	
func spawn_all_enemies():
	for x in range(9):
		for y in range(3):
			var enemy_scene_instance = enemy_scene.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 16 * 4 + y * 16)
			add_child(enemy_scene_instance)
			enemy_scene_instance.start(pos)
			enemy_scene_instance.died.connect(on_enemy_died)
			
func on_enemy_died(value) -> void:
	score += value
	$CanvasLayer/UI.update_score(score)
