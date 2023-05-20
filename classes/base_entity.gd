extends CharacterBody2D

@export var speed:int = 200
@onready var gravity:int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var grounded:bool = false

func _physics_process(delta):
	gravity_pull(delta)
	move_and_slide()

func gravity_pull(delta):
	if not grounded:
		velocity.y = gravity * delta

