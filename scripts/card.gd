class_name Card
extends Container

@onready var label = $SubViewport/CardFront2/Label

@onready var card_holder = preload("res://card/card_holder.tscn")

@onready var vp_card_back = $CardBack
@onready var vp_card_front = $CardFront

var card_num = 0
@onready var card_slot = $".."
@onready var subview = $"SubViewport"
var card_size = Vector2(0.0,0.0)

var displacement = 0.0
var damp_vel = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "ready card:" + str(card_num)
	card_size = subview.size * 2
	#position += Vector2(subview.size.x, subview.size.y)
	rot_card(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousep: Vector2 = get_global_mouse_position()
	#rot_card(mousep.x)
	# TODO 测试 damping
	if Input.is_action_just_pressed("jump"):
		damp_vel = 50.0
	var spring = 200 # spring 越小，震动的范围越大
	var damp = 10 # damp 越小，震动的次数越多
	# spring 和 damp 越大，越紧绷
	
	#print("jump")
	var force = -spring * displacement - damp * damp_vel
	damp_vel += force * delta
	displacement += damp_vel * delta
	rotation = displacement
	
func rot_card(angle):
	vp_card_front.material.set_shader_parameter("y_rot", angle)
	vp_card_back.material.set_shader_parameter("y_rot", 180.0 + angle)

func set_text(cardstr):
	card_num = cardstr
	
func _on_mouse_entered():
	print(get_local_mouse_position())
	print("Hover on")

func _on_mouse_exited():
	#self.get_child(0).hide()
	#self.queue_free()
	print("Hover out`")

func _on_gui_input(event):
	# 卡片悬浮效果
	var mouse_pos: Vector2 = get_local_mouse_position()
	var diff: Vector2 = (position + size) - mouse_pos
	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	
	var angle_x_max = 10.0
	var angle_y_max = 10.0
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)
	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	
	vp_card_front.material.set_shader_parameter("x_rot", rot_y)
	vp_card_front.material.set_shader_parameter("y_rot", rot_x)
	
	# 拖动卡片
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1: # 按下去为 1，松开为 0
			#var card_temp = card_holder.instantiate()
			var holder = get_tree().get_root().get_node("CardViewer/Holder")
			$".".reparent(holder)
			self.position = Vector2(0,0)
			print("click")
		elif event.button_mask == 0:
			print("release")
			#self.get_child(0).show()
			$".".reparent(card_slot)
			self.position = Vector2(0,0)
			#self.queue_free()
			#for i in get_tree().get_root().get_node("CardViewer/Holder").get_child_count():
			#	get_tree().get_root().get_node("CardViewer/Holder").get_child(i).queue_free()
