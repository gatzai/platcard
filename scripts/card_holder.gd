extends Control

var card_held = ""
@onready var shadow = $shadow
var max_offset_shadow = 13.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#shadow.position = Vector2(40,44)
	pass

func handle_shadow(delta: float) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var distance: float = global_position.x - center.x
	shadow.position.x = 40.0 - lerp(0.0, -sign(distance) * max_offset_shadow, abs(distance/center.x))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#handle_shadow(delta)
	self.global_position = get_global_mouse_position()
