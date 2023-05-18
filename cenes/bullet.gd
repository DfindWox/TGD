extends Area2D

var speed = 125

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	print(body)
	if body.is_in_group('Player'):
		get_tree().reload_current_scene()
	queue_free()
