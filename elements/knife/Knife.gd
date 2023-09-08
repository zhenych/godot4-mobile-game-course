extends CharacterBody2D

var is_flying := false
var is_flying_away := false

var speed := 4500.0
var fly_away_speed := 1000.0
var fly_away_rotation_speed := 1500.0
var fly_away_direction := Vector2.DOWN
var fly_away_diviation := PI / 4.0


func _physics_process( delta):
	if is_flying_away:
		global_position += fly_away_direction * fly_away_speed * delta
		rotation += fly_away_rotation_speed * delta
		return
	if is_flying:
		var collision := move_and_collide( Vector2.UP * speed * delta)
		if collision:
			handle_collision( collision)

func throw():
	is_flying = true
	
func throw_away( direction: Vector2):
	var rotation_diviation = Globals.rng.randf_range(-fly_away_diviation, fly_away_diviation)
	fly_away_direction = direction.rotated(rotation_diviation)
	is_flying = false
	is_flying_away = true
	
	
func handle_collision( collision: KinematicCollision2D):
	var collider := collision.get_collider()
	if collider is Target:
		add_knife_to_target( collider)
		is_flying = false
	else :
		throw_away(collision.get_normal())

func add_knife_to_target( target: Target):
	get_parent().remove_child( self)
	global_position = target.KNIFE_POSITION
	rotation = 0
	target.add_object_with_pivot(self, -target.rotation)
	
