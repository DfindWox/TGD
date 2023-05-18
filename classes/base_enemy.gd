extends "res://classes/base_entity.gd"

func _on_hurtbox_body_entered(body):
	if body.is_in_group('Player'):
		self.queue_free()
