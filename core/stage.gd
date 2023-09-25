extends RefCounted
class_name Stage

var knives := 0
var apples := 0
var target_scene_resorce: PackedScene

func _init(_target_scene = preload("res://elements/targets/target/target.tscn")):
	target_scene_resorce = _target_scene
	
