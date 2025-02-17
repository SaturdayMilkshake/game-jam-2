extends Node2D

@export var country_name: String = ""
@export var population: int = 50
@export_file var flag: String = ""

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
	economy.economy = starting_economy
	stability.stability = starting_stability
	military.military = starting_military

func new_turn(_turn: int) -> void:
	pass
	
func modify_country_value(country: String, _attribute: String, _modifier: int) -> void:
	if country == country_name:
		pass

func _on_map_pressed() -> void:
	SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation)
