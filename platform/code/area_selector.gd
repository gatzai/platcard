extends Control

var card_gap = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var unit_pos = mouse_pos / Vector2(card_gap, card_gap)
	var fix_pos = floor(unit_pos) * Vector2(card_gap, card_gap)
	self.global_position = fix_pos
