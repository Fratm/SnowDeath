extends KinematicBody2D

const speed = 400
var velocity = Vector2()
var screen_size = get_viewport_rect().size
var boundryLeft = 40
var boundryRight = 689
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SENSITIVITY_JUMP := -10
const SENSITIVITY_SLIDE := .5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	var myPos = get_position()
	if Input.is_action_pressed("clear_hs"):
		Globals.highScore = 0
	if Input.is_action_pressed("ui_right") and myPos.x < boundryRight:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") and myPos.x > boundryLeft:
		velocity.x -= 1
	if Input.is_action_pressed("ui_jump") and $jumping.is_stopped():
		print ("Boing!")
		$jumping.start()
		$AnimatedSprite.set_animation("Jumping")
		$CollisionShape2D.disabled = true
		
	velocity = velocity.normalized() * speed
	
	
func _physics_process(_delta):
	if Globals.gameOver:
		queue_free()
	get_input()
	var _moveslide = move_and_slide(velocity)


func _on_jumping_timeout():
	print ("Landed")
	$AnimatedSprite.set_animation("default")
	Globals.isJumping = false
	$CollisionShape2D.disabled = false
	
	pass # Replace with function body.
	

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		var swipe = event.relative
		if swipe.y < SENSITIVITY_JUMP :
			 print ("Jump")
		if swipe.x < -SENSITIVITY_SLIDE :
			 velocity.x -=1
		if swipe.x > SENSITIVITY_SLIDE :
			 velocity.x +=1
		
		velocity = velocity.normalized() * speed
		var _moveslide = move_and_slide(velocity)
		

			
	
			
