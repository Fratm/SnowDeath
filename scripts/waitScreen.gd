extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HighScore.text = str(Globals.highScore)
	$LastScore.text = str(Globals.lastScore)
	if Globals.newHighScore:
		$fireWorks.visible = true
	else:
		$fireWorks.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_buttonStart_pressed():
	Globals.gameOver = false
	get_parent().initGame()
	Globals.waitSceen = false
	Globals.newHighScore = false
	queue_free()
	
	pass # Replace with function body.
