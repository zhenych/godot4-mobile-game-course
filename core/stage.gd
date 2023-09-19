extends RefCounted
class_name Stage

var knives := 0
var apples := 0
var target_scene_resorce: PackedScene

func _init(_taget_scene = preload("res://elements/tagets/taget/taget.tscn")):
	target_scene_resorce = _taget_scene
	
