extends KinematicBody2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if Globals.gameOver:
		queue_free()
	var velocity = Vector2(0, Globals.scrollSpeed) * delta
	var collision = move_and_collide(velocity)
	if collision and collision.collider.name == "Player":
		Globals.totalDistance += 10
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
