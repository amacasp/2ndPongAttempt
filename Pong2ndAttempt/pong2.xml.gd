extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const PAD_SPEED = 200
const BALL_SPEED = 100
const FLOOR = 400
const CEILING = 0
const UP = Vector2 (0, -1)
const DOWN = Vector2 (0, 1)
const INITIAL_DIRECTION = Vector2 (1, 1)
const Y_REFLECT = Vector2 (1, -1)
const X_REFLECT = Vector2 (-1, 1)
var blueCollision
var pinkCollision
var pad_size
var bluePos
var pinkPos
var ballPos
var ballDirection

func _ready():
	set_process(true)
	pad_size = get_node("bluePad").get_texture().get_size()
	bluePos = get_node("bluePad").get_pos()
	pinkPos = get_node("pinkPad").get_pos()
	ballPos = get_node("ball").get_pos()
	ballDirection = INITIAL_DIRECTION
	blueCollision = Rect2(bluePos - pad_size * 0.5, pad_size)
	pinkCollision = Rect2(pinkPos - pad_size * 0.5, pad_size)
	
	
func _process(delta):
	#Ball Physics
	if get_node("ball").get_pos().y > FLOOR or get_node("ball").get_pos().y < CEILING :
		ballDirection = ballDirection * Y_REFLECT
	if blueCollision.has_point(ballPos) : 
		ballDirection = ballDirection * X_REFLECT
	if pinkCollision.has_point(ballPos) : 
		ballDirection = ballDirection * X_REFLECT
	
	#Pad Movement
	if Input.is_action_pressed("blue_up") and bluePos.y > CEILING:
		bluePos += PAD_SPEED * UP * delta
		get_node("bluePad").set_pos(bluePos)
		blueCollision = Rect2(bluePos - pad_size * 0.5, pad_size)
	if Input.is_action_pressed("blue_down") and bluePos.y < FLOOR:
		bluePos += PAD_SPEED * DOWN * delta
		get_node("bluePad").set_pos(bluePos)
		blueCollision = Rect2(bluePos - pad_size * 0.5, pad_size)
	
	if Input.is_action_pressed("pink_up") and pinkPos.y > CEILING :
		pinkPos += PAD_SPEED * UP * delta
		get_node("pinkPad").set_pos(pinkPos)
		pinkCollision = Rect2(pinkPos - pad_size * 0.5, pad_size)
	if Input.is_action_pressed("pink_down") and pinkPos.y < FLOOR:
		pinkPos += PAD_SPEED * DOWN * delta
		get_node("pinkPad").set_pos(pinkPos)
		pinkCollision = Rect2(pinkPos - pad_size * 0.5, pad_size)
	
	#Ball Movement	
	ballPos += BALL_SPEED * ballDirection * delta
	get_node("ball").set_pos(ballPos)
	
	#Game Over
	
	
	
