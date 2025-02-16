extends Node2D

@export var country_name: String = ""
@export var population: int = 50

@export var starting_economy: int = 5
@export var starting_stability: int = 5
@export var starting_military: int = 5

@onready var economy: Node = $Economy
@onready var stability: Node = $Stability
@onready var military: Node = $Military

func _ready() -> void:
	economy.economy = starting_economy
	stability.stability = starting_stability
	military.military = starting_military
