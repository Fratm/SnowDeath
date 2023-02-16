extends KinematicBody2D

const speed = 400
var velocity = Vector2()
var screen_size = get_viewport_rect().size
var boundryLeft = 40
var boundryRight = 689
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	var myPos = get_position()
	if Input.is_action_pressed("ui_right") and myPos.x < boundryRight:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") and myPos.x > boundryLeft:
		velocity.x -= 1
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	if Globals.gameOver:
		queue_free()
	get_input()
	move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
