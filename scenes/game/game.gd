extends Node2D

@onready var knife_shooter := $KnifeShooter
@onready var target_positon := $TargetPosition 
@onready var restart_overlay_scene := preload("res://elements/ui/restart_overlay.tscn")

var target

func _ready():
	Events.game_over.connect( end_game)
	Events.stage_changed.connect( place_target)
	Globals.change_stage( 1)

func place_target( stage: Stage):
	if target:
		target.queue_free()
	target = stage.target_scene_resorce.instantiate()
	add_child( target)
	target.add_default_items( stage.knives, stage.apples)
	target.global_position = target_positon.global_position
	

func end_game():
	knife_shooter.is_enabled = false
	show_restart_overlay()
	Globals.reset_point()
	
func show_restart_overlay():
	add_child(restart_overlay_scene.instantiate())
	Hud.update_hud_restart()
