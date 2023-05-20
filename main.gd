extends Node2D
@export var fruits:int = 1
@export var endScreen: PackedScene
func fruitHandler(n):
	fruits += n
	print('current fruits: ', fruits)
	if fruits < 1:
		print('cabo cabo cabo')
		var s = endScreen.instantiate()
		call_deferred("add_child", s)
		get_tree().paused = true
