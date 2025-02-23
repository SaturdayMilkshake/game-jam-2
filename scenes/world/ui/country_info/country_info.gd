extends Control

var add_attribute_mode: bool = true
var game_active: bool = true

@export var in_tutorial: bool = false

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("game_ended", Callable(self, "game_ended"))
	SignalHandler.connect("set_country_info_tutorial_status", Callable(self, "set_country_info_tutorial_status"))
	$InfluenceAttribute/AddAttribute.disabled = true
	$InfluenceAttribute/SubtractAttribute.disabled = false
	add_attribute_mode = true

func country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int, statuses: String) -> void:
	if game_active:
		if in_tutorial:
			$OpenEvents.text = "Back to Tutorial"
		else:
			$OpenEvents.text = "Show Events"
		self.visible = true
		$CountryName.text = country
		$Flag.texture = load(flag)
		$Population.text = "Pop.: " + str(population)
		$Economy.text = "Economy: " + str(economy)
		$Stability.text = "Stability: " + str(stability)
		$Military.text = "Military: " + str(military)
		$Cooperation.text = "Cooperation: " + str(cooperation)
		color_labels(population, economy, stability, military, cooperation)
		set_country_statuses(statuses)

func color_labels(population: int, economy: int, stability: int, military: int, cooperation: int) -> void:
	if economy <= 2:
		$Economy.add_theme_color_override("font_color", Color.INDIAN_RED)
		$Economy.add_theme_color_override("font_focus_color", Color.INDIAN_RED)
		$Economy.add_theme_color_override("font_hover_color", Color.INDIAN_RED)
	elif economy >= 10:
		$Economy.add_theme_color_override("font_color", Color.SEA_GREEN)
		$Economy.add_theme_color_override("font_focus_color", Color.SEA_GREEN)
		$Economy.add_theme_color_override("font_hover_color", Color.SEA_GREEN)
	else:
		$Economy.remove_theme_color_override("font_color")
		$Economy.remove_theme_color_override("font_focus_color")
		$Economy.remove_theme_color_override("font_hover_color")
		
	if stability <= 3:
		$Stability.add_theme_color_override("font_color", Color.INDIAN_RED)
		$Stability.add_theme_color_override("font_focus_color", Color.INDIAN_RED)
		$Stability.add_theme_color_override("font_hover_color", Color.INDIAN_RED)
	elif stability >= 10:
		$Stability.add_theme_color_override("font_color", Color.SEA_GREEN)
		$Stability.add_theme_color_override("font_focus_color", Color.SEA_GREEN)
		$Stability.add_theme_color_override("font_hover_color", Color.SEA_GREEN)
	else:
		$Stability.remove_theme_color_override("font_color")
		$Stability.remove_theme_color_override("font_focus_color")
		$Stability.remove_theme_color_override("font_hover_color")
		
	if military <= 2:
		$Military.add_theme_color_override("font_color", Color.INDIAN_RED)
		$Military.add_theme_color_override("font_focus_color", Color.INDIAN_RED)
		$Military.add_theme_color_override("font_hover_color", Color.INDIAN_RED)
	elif military >= 9:
		$Military.add_theme_color_override("font_color", Color.INDIAN_RED)
		$Military.add_theme_color_override("font_focus_color", Color.INDIAN_RED)
		$Military.add_theme_color_override("font_hover_color", Color.INDIAN_RED)
	else:
		$Military.remove_theme_color_override("font_color")
		$Military.remove_theme_color_override("font_focus_color")
		$Military.remove_theme_color_override("font_hover_color")
		
	$Cooperation.visible = true
	$InfluenceAttribute.visible = true
	$Economy.disabled = false
	$Stability.disabled = false
	$Military.disabled = false
	if cooperation <= 0:
		$Cooperation.visible = false
		$InfluenceAttribute.visible = false
		$Economy.disabled = true
		$Stability.disabled = true
		$Military.disabled = true
	elif cooperation <= 3:
		$Cooperation.add_theme_color_override("font_color", Color.INDIAN_RED)
		$Cooperation.add_theme_color_override("font_focus_color", Color.INDIAN_RED)
		$Cooperation.add_theme_color_override("font_hover_color", Color.INDIAN_RED)
	elif cooperation >= 10:
		$Cooperation.add_theme_color_override("font_color", Color.SEA_GREEN)
		$Cooperation.add_theme_color_override("font_focus_color", Color.SEA_GREEN)
		$Cooperation.add_theme_color_override("font_hover_color", Color.SEA_GREEN)
	else:
		$Cooperation.remove_theme_color_override("font_color")
		$Cooperation.remove_theme_color_override("font_focus_color")
		$Cooperation.remove_theme_color_override("font_hover_color")
		
func set_country_statuses(status: String) -> void:
	if status == "":
		$StatusesList.text = "No active statuses."
	else:
		$StatusesList.text = status

func _on_open_events_pressed() -> void:
	if in_tutorial:
		SignalHandler.emit_signal("display_notice_info", true, "Next")
		self.visible = false
	else:
		SignalHandler.emit_signal("set_event_info_visibility", true)
		self.visible = false
	$Click.play()

func new_turn() -> void:
	self.visible = false

func _on_add_attribute_pressed() -> void:
	$InfluenceAttribute/AddAttribute.disabled = true
	$InfluenceAttribute/SubtractAttribute.disabled = false
	add_attribute_mode = true
	$Click.play()

func _on_subtract_attribute_pressed() -> void:
	$InfluenceAttribute/AddAttribute.disabled = false
	$InfluenceAttribute/SubtractAttribute.disabled = true
	add_attribute_mode = false
	$Click.play()

func _on_economy_pressed() -> void:
	if in_tutorial:
		SignalHandler.emit_signal("display_notice_info", false, "Economy")
	if ((int($Economy.text) <= 10 && int($Economy.text) > 0) && !add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Economy", add_attribute_mode)
	elif ((int($Economy.text) < 10 && int($Economy.text) >= 0) && add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Economy", add_attribute_mode)

func _on_stability_pressed() -> void:
	if in_tutorial:
		SignalHandler.emit_signal("display_notice_info", false, "Stability")
	if ((int($Stability.text) <= 10 && int($Stability.text) > 0) && !add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Stability", add_attribute_mode)
	elif ((int($Stability.text) < 10 && int($Stability.text) >= 0) && add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Stability", add_attribute_mode)

func _on_military_pressed() -> void:
	if in_tutorial:
		SignalHandler.emit_signal("display_notice_info", false, "Military")
	if ((int($Military.text) <= 10 && int($Military.text) > 0) && !add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Military", add_attribute_mode)
	elif ((int($Military.text) < 10 && int($Military.text) >= 0) && add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Military", add_attribute_mode)

func _on_cooperation_pressed() -> void:
	if in_tutorial:
		SignalHandler.emit_signal("display_notice_info", false, "Cooperation")
	if ((int($Cooperation.text) <= 10 && int($Cooperation.text) > 0) && !add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Cooperation", add_attribute_mode)
	elif ((int($Cooperation.text) < 10 && int($Cooperation.text) >= 0) && add_attribute_mode):
		SignalHandler.emit_signal("influence_used", $CountryName.text, "Cooperation", add_attribute_mode)

func game_ended() -> void:
	game_active = false
	self.visible = false

func set_country_info_tutorial_status(status: bool) -> void:
	in_tutorial = status 
