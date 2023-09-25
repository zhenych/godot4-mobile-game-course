extends Target

var ACCELERATION := PI / 2

var speed_max := PI * 1.5
var speed_min := PI / 2

var acceleration := ACCELERATION

func move( delta: float):
	if speed >= speed_max:
		acceleration = -ACCELERATION
	elif speed <= speed_min:
		acceleration = ACCELERATION
	moove_with_ACCELERATION( delta)

func moove_with_ACCELERATION( delta: float):

	speed = speed + ( acceleration * delta)
	rotation -= speed * delta
