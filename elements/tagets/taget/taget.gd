extends CharacterBody2D
class_name Target

const GENERATION_LIMIT := 10
const KNIFE_POSITION = Vector2( 0, 180)
const APPLE_POSITION = Vector2(0, 176)
const OBJECT_MARGINE := PI / 6

var knife_scene: PackedScene = load("res://elements/knife/knife.tscn")
var apple_scene: PackedScene = load("res://elements/apple/apple.tscn")

var speed := PI

@onready var items_container := $ItemsContainer

func _ready():
	add_default_items( 3, 2)

func _physics_process( delta: float):
	rotation += speed * delta

func add_object_with_pivot( object: Node2D, object_rotation: float):
	var pivot := Node2D.new()
	pivot.rotation = object_rotation
	pivot.add_child( object)
	items_container.add_child( pivot)
	
func add_default_items( knives: int, apples: int):
	var occupied_rotations := []
	for i in knives:
		var pivot_rotation = get_free_random_rotation(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)
		var knife := knife_scene.instantiate()
		knife.position = KNIFE_POSITION
		add_object_with_pivot(knife, pivot_rotation)
		
	for i in apples:
		var pivot_rotation = get_free_random_rotation(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)
		var apple := apple_scene.instantiate()
		apple.position = APPLE_POSITION
		add_object_with_pivot(apple, pivot_rotation)

func get_free_random_rotation( occupied_rotations: Array, generation_attempts = 0):
	if generation_attempts >= GENERATION_LIMIT:
		return null
		
	var random_rotation := Globals.rng.randf_range( 0, 2 * PI)
	
	for occupied in occupied_rotations:
		if random_rotation <= occupied + OBJECT_MARGINE / 2 and random_rotation >= occupied - OBJECT_MARGINE / 2:
			return get_free_random_rotation(occupied_rotations, generation_attempts + 1)
	
	return random_rotation
