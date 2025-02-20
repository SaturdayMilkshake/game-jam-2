extends Control

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))

func country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int) -> void:
	reset_label_color()
	self.visible = true
	$CountryName.text = country
	$Flag.texture = load(flag)
	$Population.text = "Pop.: " + str(population)
	$Economy.text = "Economy: " + str(economy)
	$Stability.text = "Stability: " + str(stability)
	$Military.text = "Military: " + str(military)
	$Cooperation.text = "Cooperation: " + str(cooperation)
	color_labels(population, economy, stability, military, cooperation)

func reset_label_color() -> void:
	$Economy.modulate = Color(1.0, 1.0, 1.0, 1.0)
	$Stability.modulate = Color(1.0, 1.0, 1.0, 1.0)
	$Military.modulate = Color(1.0, 1.0, 1.0, 1.0)
	$Cooperation.modulate = Color(1.0, 1.0, 1.0, 1.0)

func color_labels(population: int, economy: int, stability: int, military: int, cooperation: int) -> void:
	if economy <= 3:
		$Economy.modulate = Color.INDIAN_RED
	elif economy >= 10:
		$Economy.modulate = Color.SEA_GREEN
		
	if stability <= 3:
		$Stability.modulate = Color.INDIAN_RED
	elif stability >= 10:
		$Stability.modulate = Color.SEA_GREEN
		
	if military <= 3:
		$Military.modulate = Color.INDIAN_RED
	elif military >= 10:
		$Military.modulate = Color.INDIAN_RED
		
	$Cooperation.visible = true
	if cooperation <= 0:
		$Cooperation.visible = false
	elif cooperation <= 3:
		$Cooperation.modulate = Color.INDIAN_RED
	elif cooperation >= 10:
		$Cooperation.modulate = Color.SEA_GREEN

func _on_open_events_pressed() -> void:
	SignalHandler.emit_signal("set_event_info_visibility", true)
	self.visible = false

func new_turn() -> void:
	self.visible = false
