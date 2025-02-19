extends Control

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))

func country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int) -> void:
	self.visible = true
	$CountryName.text = country
	$Flag.texture = load(flag)
	$Population.text = "Pop.: " + str(population)
	$Economy.text = "Economy: " + str(economy)
	$Stability.text = "Stability: " + str(stability)
	$Military.text = "Military: " + str(military)
	$Cooperation.text = "Cooperation: " + str(cooperation)

func _on_new_event_pressed() -> void:
	self.visible = false
	SignalHandler.emit_signal("new_event_requested")
