extends CharacterBody2D

enum State {IDLE, FLY_TO_TARGET, FLY_AWAY}

var state := State.IDLE

var speed := 4500.0
var fly_away_speed := 1000.0
var fly_away_rotation_speed := 1500.0
var fly_away_direction := Vector2.DOWN
var fly_away_diviation := PI / 4.0

@onready var knife_texture := $Sprite2D

func _ready():
	knife_texture.texture = Globals.KNIFE_TEXTURES[ Globals.active_knife_index]

func _physics_process( delta):
	match state:
		State.FLY_TO_TARGET:
			var collision := move_and_collide( Vector2.UP * speed * delta)
			if collision:
				handle_collision( collision)
		State.FLY_AWAY:
			global_position += fly_away_direction * fly_away_speed * delta
			rotation += fly_away_rotation_speed * delta

func change_state( new_state: State):
	state = new_state

func throw():
	change_state(State.FLY_TO_TARGET)
	
func throw_away( direction: Vector2):
	var rotation_diviation = Globals.rng.randf_range(-fly_away_diviation, fly_away_diviation)
	fly_away_direction = direction.rotated(rotation_diviation)
	change_state(State.FLY_AWAY)
	
func handle_collision( collision: KinematicCollision2D):
	var collider := collision.get_collider()
	if collider is Target:
		add_knife_to_target( collider)
		change_state(State.IDLE)
		collider.take_damage()
		Globals.add_point()
	else :
		SfxPlayer.play_track(SfxPlayer.AUDIO_TRACKS.KnifeHit)
		throw_away(collision.get_normal())
		Events.game_over.emit()

func add_knife_to_target( target: Target):
	get_parent().remove_child( self)
	global_position = target.KNIFE_POSITION
	rotation = 0
	target.add_object_with_pivot(self, -target.rotation)
	
