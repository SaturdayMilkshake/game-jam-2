extends Node2D

@export var country_name: String = ""
@export var population: int = 50
@export_file var flag: String = ""
@export_file var map: String = ""
@export_file var mask: String = ""

@export var starting_economy: int = 5
@export var starting_stability: int = 5
@export var starting_military: int = 5
@export var starting_cooperation: int = 5

@onready var economy: Node = $Economy
@onready var stability: Node = $Stability
@onready var military: Node = $Military
@onready var cooperation: Node = $Cooperation

var statuses: Array = []
var status_descriptions: Array = []

#Statuses:
#Nuclear Weapons
var nuclear_state: bool = false
var nuclear_program_progression_active: bool = false
var nuclear_program_progress: int = 0

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("modify_country_value", Callable(self, "modify_country_value"))
	$Map.texture_normal = load(map)
	var bitmap: BitMap = BitMap.new()
	var source_image: Image = load(map).get_image()
	bitmap.create_from_image_alpha(source_image)
	$Map.texture_click_mask = bitmap
	generate_starting_attribute_values()

func new_turn() -> void:
	population += (economy.economy - 5) + (stability.stability - 5)
	if nuclear_program_progression_active:
		nuclear_program_progress += military.military
	if nuclear_program_progress >= 10:
		nuclear_state = true
	
func generate_starting_attribute_values() -> void:
	economy.economy = randi_range(4, 6)
	stability.stability = randi_range(4, 6)
	military.military = randi_range(4, 6)
	cooperation.cooperation = randi_range(4, 6)
	population = randi_range(45, 55)
	
func modify_country_value(country: String, attribute: String, modifier: int) -> void:
	if country == country_name:
		match attribute:
			"Economy":
				economy.modify_economy(modifier)
				if modifier > 0:
					$Status.text += "[center][color=darkgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=firebrick]-"
				$Status.text += "Economy"
			"Stability":
				stability.modify_stability(modifier)
				if modifier > 0:
					$Status.text += "[center][color=darkgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=firebrick]-"
				$Status.text += "Stability"
			"Military":
				military.modify_military(modifier)
				if modifier > 0:
					$Status.text += "[center][color=darkgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=firebrick]-"
				$Status.text += "Military"
			"Cooperation":
				cooperation.modify_cooperation(modifier)
				if modifier > 0:
					$Status.text += "[center][color=darkgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=firebrick]-"
				$Status.text += "Cooperation"
			"Population":
				population += modifier
				$Status.text += "Population"
			"NuclearProgress":
				nuclear_program_progression_active = true
			"Peace":
				pass
	elif country == "ALL":
		pass
	$Status.text += "\n"
	$Status.text.strip_edges()
	move_status_label()
	#SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation)

func _on_map_pressed() -> void:
	SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation)

func _on_map_mouse_entered() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_map_mouse_exited() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)

func move_status_label() -> void:
	var tween: Tween = create_tween()
	$Status.visible = true
	tween.tween_property($Status, "position", $Status.position + Vector2(0, -25), 1).set_trans(Tween.TRANS_CIRC)
	tween.tween_callback(reset_status_label_position)

func reset_status_label_position() -> void:
	$Status.visible = false
	$Status.position -= Vector2(0, -25)
	$Status.text = ""
