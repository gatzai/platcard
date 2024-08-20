extends HBoxContainer

@onready var card_scene = preload("res://card/card_slot.tscn")
@onready var card_container = $"."

var start_pos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	var num = 3
	for i in range(num):
		var card = card_scene.instantiate() as Card
		#card.set_text(i+1)
		add_child(card)
		#card.global_position = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	var target_pos = start_pos + Vector2(0, -30)
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween1.tween_property(self, "position", target_pos, 0.2)
	tween2.tween_property(self, "scale", Vector2(1.2, 1.2), 0.2)

func _on_mouse_exited():
	if true: # 如果鼠标没有拿卡片，那么可以收入卡牌
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween1.tween_property(self, "position", start_pos, 0.2)
		tween2.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
