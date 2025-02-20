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
	generate_starting_attribute_values()

func new_turn() -> void:
	population += (economy.economy - 5) + (stability.stability - 5)
	
func generate_starting_attribute_values() -> void:
	economy.economy = randi_range(3, 7)
	stability.stability = randi_range(3, 7)
	military.military = randi_range(3, 7)
	cooperation.cooperation = randi_range(3, 7)
	population = randi_range(40, 60)
	
func modify_country_value(country: String, attribute: String, modifier: int) -> void:
	if country == country_name:
		if modifier > 0:
			$Status.text += "[center][color=darkgreen]+"
		elif modifier < 0:
			$Status.text += "[center][color=firebrick]-"

		match attribute:
			"Economy":
				economy.modify_economy(modifier)
				$Status.text += "Economy"
			"Stability":
				stability.modify_stability(modifier)
				$Status.text += "Stability"
			"Military":
				military.modify_military(modifier)
				$Status.text += "Military"
			"Cooperation":
				cooperation.modify_cooperation(modifier)
				$Status.text += "Cooperation"
			"Population":
				population += modifier
				$Status.text += "Population"
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
