extends Area2D

@onready var animation = $AnimationPlayer
func _on_body_entered(body):
	if body.is_in_group('Player'):
		animation.play("collected")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'collected':
		self.queue_free()
		#say farewell and kill yourself
