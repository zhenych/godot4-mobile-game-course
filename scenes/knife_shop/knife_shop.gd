extends Control

@onready var grid_container := $MarginContainer/VBoxContainer/GridContainer

func _ready():
	for i in range(Globals.KNIFE_TEXTURES.size()):
		var shop_item := grid_container.get_child( i)
		shop_item.initialize( i)
		
func _on_unlock_button_pressed():
	
	if Globals.apples < Globals.UNLOCK_COST:
		return
		
	var locked_knives := []
	for i in range(Globals.KNIFE_TEXTURES.size()):
		if not Globals.is_knife_unlocked( i) :
			locked_knives.append( i)
	
	if locked_knives.is_empty():
		return
		
	var random_index = locked_knives.pick_random()
	
	Globals.unlock_knife( random_index)
	Globals.add_apples( -Globals.UNLOCK_COST)
	grid_container.get_child( random_index).unlock()
