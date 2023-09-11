extends Node2D

const EXPLOSION_TIME := 1.0

var is_hited := false


@onready var sprite := $Sprite2D
@onready var apple_particles := [
	$AppleParticles2D,
	$AppleParticles2D2
]

func _on_area_2d_body_entered(body):
	if not is_hited:
		is_hited = true
		apple_explode()		

func apple_explode():
	sprite.hide()
	
	var tween := create_tween()
	
	for _item in apple_particles:
		var apple : CPUParticles2D = _item
		apple.emitting = true
		tween.parallel().tween_property(apple, "modulate", Color("ffffff00"), EXPLOSION_TIME)
	tween.play()
	await tween.finished
	queue_free()
