extends KinematicBody2D
var dingPlaying = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Globals.gameOver:
		queue_free()
	var velocity = Vector2(0, Globals.scrollSpeed) * delta
	var _collision = move_and_collide(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	Globals.totalDistance += 10
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(.75), "timeout")
	$AudioStreamPlayer2D.stop()
	queue_free()

	pass # Replace with function body.
