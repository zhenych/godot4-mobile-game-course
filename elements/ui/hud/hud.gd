extends CanvasLayer

@onready var knives_counter := %KnivesCounter
@onready var home_button := %HomeButton
@onready var point_label := %PointLabel
@onready var stage_counter := %StageCounter
@onready var stage_label := %StageLable
#@onready var apple_counter := %ApplesCounter

func _ready():
	Events.location_changed.connect(update_hud_location)
	update_hud_location(Events.LOCATIONS.START)
	print_debug("Hud init")

func _on_home_button_pressed():
	Events.location_changed.emit( Events.LOCATIONS.START)

func update_hud_location( location: Events.LOCATIONS):
	print_debug("update_hud ", location)
	match location:
		Events.LOCATIONS.START:
			knives_counter.hide()
			home_button.hide()
			point_label.hide()
			stage_counter.hide()
			stage_label.hide()
			
		Events.LOCATIONS.GAME:
			knives_counter.show()
			home_button.hide()
			point_label.show()
			stage_counter.show()
			stage_label.show()
			
		Events.LOCATIONS.SHOP:
			knives_counter.hide()
			home_button.show()
			point_label.hide()
			stage_counter.hide()
			stage_label.hide()

func update_hud_restart():
	knives_counter.hide()
	home_button.show()
	point_label.hide()
	stage_counter.hide()
	stage_label.hide()
