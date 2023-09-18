extends Node2D

@onready var knife_shooter := $KnifeShooter
@onready var restart_overlay_scene := preload("res://elements/ui/restart_overlay.tscn")
#@onready var restart_overlay_scene := $RestartOverlay

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.game_over.connect(end_game)

func end_game():
	knife_shooter.is_enabled = false
	show_restart_overlay()
	Globals.reset_point()
	
func show_restart_overlay():
	add_child(restart_overlay_scene.instantiate())
	Hud.update_hud_restart()
