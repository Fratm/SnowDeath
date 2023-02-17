extends Node

var newHighScore = false
var scrollSpeed = 500
var totalDistance = 0
var gameOver = true
var lastScore = 0
var startPosition = Vector2(359,1200)
var waitSceen = false
var highScore = 0
var isJumping = false
var touch = OS.has_touchscreen_ui_hint()  #Check for touch screen
