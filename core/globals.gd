extends Node

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
#	rng.seed = -2364680567785300547
	print_debug(rng.seed)
