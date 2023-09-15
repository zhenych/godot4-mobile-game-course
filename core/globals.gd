extends Node

const location_to_scene = {
	Events.LOCATIONS.GAME: preload("res://scenes/game/game.tscn"),
	Events.LOCATIONS.SHOP: preload("res://scenes/knife_shop/knife_shop.tscn"),
	Events.LOCATIONS.START: preload("res://scenes/start_screen/start_screen.tscn")
}

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
#	rng.seed = -2364680567785300547
	print_debug( rng.seed)
	
	Events.location_changed.connect(handle_location_change)

func handle_location_change( location: Events.LOCATIONS):
	get_tree().change_scene_to_packed(location_to_scene.get(location))
