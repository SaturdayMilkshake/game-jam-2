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

var statuses: Array = [
	"[color=orange]Nuclear State[/color]",
	"[color=gray]Backed Out[/color]"
]
var status_descriptions: Array = [
	"Will launch nukes as a last resort when Military reaches 2.",
	"This country's attributes can no longer be influenced."
	]

var status_text: String = ""

#Statuses:
#Nuclear Weapons
var nuclear_state: bool = false
var nuclear_program_progression_active: bool = false
var nuclear_program_progress: int = 0

#Peace
var treaty_signed: bool = false

#Backed Out
var backed_out: bool = false

var original_status_label_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("modify_country_value", Callable(self, "modify_country_value"))
	SignalHandler.connect("update_country_info", Callable(self, "update_country_info"))
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	$Map.texture_normal = load(map)
	var bitmap: BitMap = BitMap.new()
	var source_image: Image = load(map).get_image()
	bitmap.create_from_image_alpha(source_image)
	$Map.texture_click_mask = bitmap
	generate_starting_attribute_values()
	original_status_label_position = $Status.position
	$Status.visible = false

func new_turn() -> void:
	if nuclear_program_progression_active:
		nuclear_program_progress += military.military
	if nuclear_program_progress >= 50 && !nuclear_state:
		nuclear_state = true
		$Status.text += "[center][color=white]Nuclear State[/color]"
	if cooperation.cooperation <= 0 && !backed_out:
		backed_out = true
		$Status.text += "[center][color=white]Backed Out[/color]"
		
	#attributes
	if economy.economy <= 2:
		SignalHandler.emit_signal("no_economy")
		var affected_attribute: int = randi_range(1, 3)
		match affected_attribute:
			1:
				modify_country_value(country_name, "Stability", -1)
			2:
				modify_country_value(country_name, "Military", -1)
			3:
				modify_country_value(country_name, "Cooperation", -1)
	if economy.economy >= 10:
		SignalHandler.emit_signal("excess_economy")
	if stability.stability <= 3:
		SignalHandler.emit_signal("no_stability")
	if military.military <= 2:
		SignalHandler.emit_signal("no_military")
		if nuclear_state:
			SignalHandler.emit_signal("game_over", "Nuclear Exchange")
	if military.military >= 9:
		SignalHandler.emit_signal("excess_military")
	if cooperation.cooperation <= 0:
		SignalHandler.emit_signal("no_cooperation")
	if cooperation.cooperation >= 10:
		SignalHandler.emit_signal("excess_cooperation")
	
func generate_starting_attribute_values() -> void:
	economy.economy = randi_range(4, 6)
	stability.stability = randi_range(4, 6)
	military.military = randi_range(4, 6)
	cooperation.cooperation = randi_range(4, 6)
	population = randi_range(45, 55)
	
func modify_country_value(country: String, attribute: String, modifier: int) -> void:
	if country == country_name:
		$Status.size = $Status.get_minimum_size()
		match attribute:
			"Economy":
				economy.modify_economy(modifier)
				if modifier > 0:
					$Status.text += "[center][color=lightgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=indianred]-"
				$Status.text += "Economy"
				$Status.text += "\n"
			"Stability":
				stability.modify_stability(modifier)
				if modifier > 0:
					$Status.text += "[center][color=lightgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=indianred]-"
				$Status.text += "Stability"
				$Status.text += "\n"
			"Military":
				military.modify_military(modifier)
				if modifier > 0:
					$Status.text += "[center][color=lightgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=indianred]-"
				$Status.text += "Military"
				$Status.text += "\n"
			"Cooperation":
				cooperation.modify_cooperation(modifier)
				if modifier > 0:
					$Status.text += "[center][color=lightgreen]+"
				elif modifier < 0:
					$Status.text += "[center][color=indianred]-"
				$Status.text += "Cooperation"
				$Status.text += "\n"
			"Population":
				population += modifier
				$Status.text += "Population"
				$Status.text += "\n"
			"NuclearProgress":
				nuclear_program_progression_active = true
			"Peace":
				pass
		if $Status.text != "":
			move_status_label()
	elif country == "ALL":
		pass
	else:
		pulse_country(false)

func _on_map_pressed() -> void:
	status_text = ""
	check_statuses()
	pulse_country(true)
	SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation, status_text)
	$Click.play()

func _on_map_mouse_entered() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_map_mouse_exited() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)

func move_status_label() -> void:
	var tween = create_tween()
	if tween:
		if tween.is_running():
			tween.kill()
		tween = create_tween()
		$Status.visible = true
		tween.tween_property($Status, "position", $Status.position + Vector2(0, -10), 1).set_trans(Tween.TRANS_CIRC)
		tween.tween_callback(reset_status_label_position)
	else:
		tween = create_tween()
		$Status.visible = true
		tween.tween_property($Status, "position", $Status.position + Vector2(0, -10), 1).set_trans(Tween.TRANS_CIRC)
		tween.tween_callback(reset_status_label_position)

func reset_status_label_position() -> void:
	$Status.visible = false
	$Status.position = original_status_label_position
	$Status.text = ""

func update_country_info(country: String) -> void:
	if country_name == country:
		status_text = ""
		check_statuses()
		pulse_country(true)
		SignalHandler.emit_signal("country_selected", country_name, flag, population, economy.economy, stability.stability, military.military, cooperation.cooperation, status_text)
	else:
		pulse_country(false)

func check_statuses() -> void:
	if nuclear_state:
		status_text += statuses[0] + "\n"
		status_text += status_descriptions[0] + "\n"
	if backed_out:
		status_text += statuses[1] + "\n"
		status_text += status_descriptions[1]+ "\n"

func pulse_country(status: bool) -> void:
	$Map.material.set("shader_parameter/pulsing_active", status)

func country_selected(country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int, _statuses: String) -> void:
	if country_name == country:
		pass
	else:
		pulse_country(false)
