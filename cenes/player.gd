extends "res://classes/base_entity.gd"
@export var jump_speed:int = -15000
@onready var timer_jump = $TimerJump
@onready var animation = $Animation
var canChangeStatus:bool = true
var state:String = 'idle'

func _physics_process(delta):
	#change name from input to physics, maybe? send those their own functions
	#I'd organize all that if I had the time to
	physics(delta)
	gravity_pull(delta)
	handle_animation()
	handle_input()
	move_and_slide()

func physics(delta):
	var jumping:int
	if state == 'jumping':
		jumping = jump_speed * delta
	
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			jumping)* delta
	handle_rotation(input_direction)


	if input_direction != Vector2.ZERO and canChangeStatus:
		state = 'running'
	elif canChangeStatus:
		if grounded:
			state = 'idle'
		else:
			state = 'falling'
	
	velocity = input_direction * speed


func _on_timer_jump_timeout():
	grounded = false
	state = 'falling'

func _on_tact_body_entered(body):
	if body.is_in_group('Map') and state != 'jumping':
		grounded = true
		canChangeStatus = true
		state = 'idle'

func _on_tact_body_exited(body):
	if body.is_in_group('Map') and canChangeStatus:
		grounded = false
		state = 'falling'

func handle_animation():
	animation.play(state)

func handle_rotation(input_direction):
	if input_direction.x > 0:
		$Sprite.set_flip_h(false)
	if  input_direction.x < 0:
		$Sprite.set_flip_h(true)

func handle_input():
	if Input.is_action_just_pressed("ui_accept"):
		if grounded and not state == 'jumping':
			state = 'jumping'
			canChangeStatus = false
			timer_jump.start()
