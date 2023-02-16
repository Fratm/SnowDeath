extends Node2D

var myTree = preload("res://scenes/tree001.tscn")
var waitScreen = preload("res://scenes/waitScreen.tscn")
var thePlayer = preload("res://scenes/Player.tscn")
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#initGame()
	pass # Replace with function body.




func _process(delta):
	if Globals.gameOver:
		if !Globals.waitSceen:
			print ("Spawning wait sceen")
			var myWaitSceen = waitScreen.instance()
			add_child(myWaitSceen)
			Globals.waitSceen = true
		return
	$distanceHUD.text = "Distance Traveled :" + str(Globals.totalDistance * 10) + " yards."
	if $spawnTimer.is_stopped():
		Globals.totalDistance +=1
		rng.randomize()
		var howMany = rng.randf_range(1, 5)
		while howMany > 0:
			var aTree = myTree.instance()
			aTree.position = Vector2(rng.randf_range(20.0, 710),-20)
			$TreeBucket.add_child(aTree)
			howMany -= 1
		$spawnTimer.wait_time = rng.randf_range(1, 3)
		$spawnTimer.start()
	if $speedUpTimer.is_stopped():
		Globals.scrollSpeed *= 1.01
		print ("Speed : " , Globals.scrollSpeed)
		# for N in $TreeBucket.get_children():
		#	N.treeSpeed = Globals.scrollSpeed
		$speedUpTimer.start()
			
#Set up a new game.  
func initGame():
	Globals.gameOver = false
	$distanceHUD.visible = true
	var Player = thePlayer.instance()
	Player.position = Globals.startPosition
	add_child(Player)

#What to do when game is over
func gameOver():
	Globals.gameOver = true
	
