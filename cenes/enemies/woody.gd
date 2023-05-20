extends "res://classes/base_enemy.gd"

@export var Bullet: PackedScene
@onready var animation = $Animation
var target = false
func _on_radar_entered(body):
	if body.is_in_group('Player'):
		target = true
		animation.play('attack')

func _on_radar_body_exited(body):
	if body.is_in_group('Player'):
		target = false

func shoot():
	var s = Bullet.instantiate()
	owner.call_deferred("add_child", s)
	s.transform = $Marker.global_transform



func _on_animation_finished(anim_name):
	if anim_name == 'attack':
		shoot()
	if target:
		animation.play('attack')
	else:animation.play('idle')
