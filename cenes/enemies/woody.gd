extends "res://classes/base_enemy.gd"

@export var Bullet: PackedScene

func _on_radar_entered(body):
	if body.is_in_group('Player'):
		$Timer.start()

func _on_radar_body_exited(body):
	if body.is_in_group('Player'):
		$Timer.stop()

func shoot():
	var s = Bullet.instantiate()
	owner.call_deferred("add_child", s)
	s.transform = $Marker.global_transform

func _on_timer_timeout():
	shoot()



