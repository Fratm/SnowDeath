extends Node2D

var myTree = preload("res://scenes/tree001.tscn")
var waitScreen = preload("res://scenes/waitScreen.tscn")
var thePlayer = preload("res://scenes/Player.tscn")
var coin = preload("res://scenes/coin.tscn")

var rng = RandomNumberGenerator.new()
var rngcoin = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadcfg()
	if Globals.touch:
		$DEBUG.text = "TOUCH!"
	pass # Replace with function body.

func _process(_delta):
	if Globals.gameOver:
		if !Globals.waitSceen:
			var myWaitSceen = waitScreen.instance()
			add_child(myWaitSceen)
			$distanceHUD.visible = false
			$score.visible = false
			Globals.waitSceen = true
		return
	$score.text = str(Globals.totalDistance * 10)
	_spawnSpecial()
	spawnTrees()

	if $speedUpTimer.is_stopped():
		Globals.scrollSpeed *= 1.01
		$speedUpTimer.start()
			
 
#Tree Spawner
func spawnTrees():
	if $spawnTimer.is_stopped():
		Globals.totalDistance +=1
		rng.randomize()
		var howMany = rng.randf_range(1, 15)
		while howMany > 0:
			var aTree = myTree.instance()
			aTree.position = Vector2(rng.randf_range(20.0, 710),-20)
			$TreeBucket.add_child(aTree)
			howMany -= 1
		$spawnTimer.wait_time = rng.randf_range(.5, 2)
		$spawnTimer.start()

func _spawnSpecial():
	rngcoin.randomize()
	var dropCoin = rngcoin.randf_range(1, 1000)
	if dropCoin <15:
		print ("Dropping coin!")
		var aCoin = coin.instance()
		aCoin.position = Vector2(rngcoin.randf_range(20.0, 710),-50)
		$TreeBucket.add_child(aCoin)
	

#Set up a new game. 
func initGame():
	Globals.gameOver = false
	$distanceHUD.visible = true
	$score.visible = true
	$score.text = "0"
	var Player = thePlayer.instance()
	Player.position = Globals.startPosition
	Globals.totalDistance = 0
	Globals.scrollSpeed = 500
	add_child(Player)

#What to do when game is over
func gameOver():
	Globals.gameOver = true
	Globals.lastScore = int($score.text)
	$distanceHUD.visible = false
	$score.visible = false
	if Globals.highScore < Globals.lastScore:
		Globals.highScore = Globals.lastScore
		Globals.newHighScore = true
	save()
	
func save():
	var save_data = {
		"highscore": Globals.highScore,
		"lastscore": Globals.lastScore,
	}
	var cfgFile = File.new()
	cfgFile.open("user://snowdeath.cfg", File.WRITE)
	cfgFile.store_line(to_json(save_data))
	cfgFile.close()
	
func loadcfg():
	var cfgFile = File.new()
	cfgFile.open("user://snowdeath.cfg", cfgFile.READ)
	var data = parse_json(cfgFile.get_as_text())
	print ("Data: ", data)
	if data:
		Globals.highScore = data.highscore
		Globals.lastScore = data.lastscore
	
	
	
