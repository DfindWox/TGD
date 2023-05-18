extends "res://classes/base_entity.gd"
@export var jump_speed:int = -15000
@onready var is_jumping:bool = false
@onready var timer_jump = $TimerJump
func _physics_process(delta):
	#change name from input to physics, maybe? send those their own functions
	handle_input(delta)
	gravity_pull(delta)
	if Input.is_action_just_pressed("ui_accept"):
		if grounded:
			is_jumping = true
			timer_jump.start()
	move_and_slide()

func handle_input(delta):
	var jumping:int
	if is_jumping:
		jumping = jump_speed * delta
	
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			jumping)* delta
	
	velocity = input_direction * speed




func _on_timer_jump_timeout():
	is_jumping = false
	grounded = false

func _on_tact_body_entered(body):
	print(body,' is inside me')
	if body.is_in_group('Map'):
		grounded = true


func _on_tact_body_exited(body):
	if body.is_in_group('Map') and not is_jumping:
		grounded = false


#	var TW = create_tween()
#	#Em vez dessa parada, eu tiro a gravity, seto pra 'jumping' e vlay
#	var vlaay = Vector2(self.position.x , self.position.y + jump_speed)
#	TW.tween_property(self, 'position', vlaay, 0.3)
