extends Area2D

@export var speed = 150
@onready var screensize = get_viewport_rect().size
var ship_size = $CollisionShape2D.shape.extents


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += input * speed * delta
	position = position.clamp((ship_size / 2), screensize - (ship_size / 2))
	
	
	pass
