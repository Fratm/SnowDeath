extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Globals.gameOver:
		queue_free()
	var velocity = Vector2(0, Globals.scrollSpeed) * delta
	var collision = move_and_collide(velocity)
	if collision and collision.collider.name == "Player":
		get_parent().get_parent().gameOver()
		
	#self.position.y += delta * Globals.scrollSpeed

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.

