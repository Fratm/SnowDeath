extends ParallaxBackground


func _process(delta):
	scroll_offset.y += Globals.scrollSpeed * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
