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

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("modify_country_value", Callable(self, "modify_country_value"))
	$Map.texture_normal = load(map)
	var bitmap: BitMap = BitMap.new()
	var source_image: Image = load(map).get_image()
	bitmap.create_from_image_alpha(source_image)
	$Map.texture_click_mask = bitmap
	economy.economy = starting_economy
	stability.stability = starting_stability
	military.military = starting_military

func new_turn(_turn: int) -> void:
	pass
	
func modify_country_value(country: String, attribute: String, modifier: int) -> void:
	if country == country_name:
		match attribute:
			"Economy":
				economy.economy += modifier
			"Stability":
				stability.stability += modifier
			"Military":
				military.military += modifier
			"Cooperation":
				cooperation.cooperation += modifier
			"Population":
				population += modifier
		SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation)

func _on_map_pressed() -> void:
	SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation)

func _on_map_mouse_entered() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_map_mouse_exited() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
