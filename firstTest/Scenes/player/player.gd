extends Area2D

signal died
signal shield_changed

@onready var screensize = get_viewport_rect().size		#地圖邊界

#利用CollisionShape2D的邊界當作船體大小
@onready var ship_size = $CollisionShape2D.shape.get_rect().end

@onready var ship : Sprite2D = $ship
@onready var boosters : AnimatedSprite2D = $ship/boosters
@onready var gun_cooldown_timer : Timer = $GunCooldownTimer

@export var speed = 150		#移動速度
@export var cooldown = 0.25
@export var bullet_scene : PackedScene
@export var maxshield = 10

var can_shoot = true
var shield = maxshield : set = set_shield

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	
func start() -> void:
	position = Vector2(screensize.x /2 , screensize.y - 64)
	gun_cooldown_timer.wait_time = cooldown
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input.x > 0:
		ship.frame = 2
		boosters.animation = "right"
	elif input.x < 0:
		ship.frame = 0
		boosters.animation = "left"
	else:
		ship.frame = 1
		boosters.animation = "forward"
	position += input * speed * delta
	position = position.clamp(ship_size, screensize - ship_size)
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot() -> void:
	if not can_shoot:
		return
	can_shoot = false
	gun_cooldown_timer.start()
	var bullet_scene_instance = bullet_scene.instantiate()
	get_tree().root.add_child(bullet_scene_instance)
	bullet_scene_instance.start(position + Vector2(0 , -8))
	
func set_shield(value) -> void:
	shield = min(maxshield, value)
	shield_changed.emit(maxshield, shield)
	if shield <= 0:
		hide()
		died.emit()
	
func _on_gun_cooldown_timer_timeout() -> void:
	can_shoot = true
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.explode()
		shield -= maxshield / 2
		

