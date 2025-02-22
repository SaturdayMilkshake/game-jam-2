extends Control

func _ready() -> void:
	SignalHandler.connect("influence_updated", Callable(self, "influence_updated"))
	self.modulate = Color.INDIAN_RED

func _process(delta: float) -> void:
	pass

func influence_updated(influence: int) -> void:
	if influence >= 5:
		self.modulate = Color.DODGER_BLUE
	elif influence <= 0:
		self.modulate = Color.INDIAN_RED
	else:
		self.modulate = Color.WHITE
	$Influence.text = "Influence: " + str(influence)
