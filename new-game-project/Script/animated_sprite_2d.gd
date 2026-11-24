extends AnimatedSprite2D

var speed: float = 5.00
@onready var light: PointLight2D = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.idle()
	
	# signal connect
	frame_changed.connect(_on_frame_changed)
	animation_finished.connect(_on_animation_finished)
	pass # Replace with function body.

func shoot()-> void:
	self.play("shoot")

func _on_frame_changed() -> void:
	if animation == "shoot":
		match frame:
			0:
				light.energy = 1  # Frame 0
				light.texture_scale = 0.9
			1:
				light.energy = 0.8  # Frame 1
				light.texture_scale = 0.8
				
				
func _on_animation_finished() -> void:
	if animation == "shoot":
		light.energy = 0.0

func idle()-> void:
	self.play("idle")
	light.energy = 0.4
	light.texture_scale = 0.6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		print("Key_a pressed")
		self.position.x -= speed
		
	if Input.is_key_pressed(KEY_W):
		print("Key_w pressed")
		self.position.y -= speed
		
	if Input.is_key_pressed(KEY_S):
		print("Key_s pressed")
		self.position.y += speed
		
	if Input.is_key_pressed(KEY_D):
		print("Key_d pressed")
		self.position.x += speed
	pass

func  _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Left clicked at: ", event.position)
			self.shoot()
		else:
			self.idle()
			print("Left click released")
	pass

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	pass	
