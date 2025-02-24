extends Node

var countries: Array[String] = ["Satura", "Carateria", "Leipand", "Lumeburg", "Canorland", "Southern Isles"]

var events: Array = [["1", "COUNTRY1 and COUNTRY2 are having a dispute on the status of newly-found islands. COUNTRY1 claims historical rights, while COUNTRY2 brings up a treaty signed by both countries that awards islands to the country closest to it.", "RANDOM", "RANDOM", "Award to COUNTRY1", "Award to COUNTRY2", "Cooperation", "2", "Military", "1", "Cooperation", "-3", "", "", "Cooperation", "-2", "", "", "Cooperation", "1", "Military", "1"], ["2", "A massive oil deposit has been found at the border of COUNTRY1 and COUNTRY2. However, they both claim a majority of the area, and turn to you to settle this dispute.", "RANDOM", "RANDOM", "Favor COUNTRY1", "Favor COUNTRY2", "Economy", "2", "Cooperation", "2", "Economy", "1", "Cooperation", "-2", "Economy", "1", "Cooperation", "-1", "Economy", "2", "Cooperation", "2"], ["3", "A group of refugees turn up at a COUNTRY1 border checkpoint. COUNTRY1 is uncertain about them, and refuses to let them in, leaving them in COUNTRY2.", "RANDOM", "RANDOM", "Accept Refugees", "Turn Away Refugees", "Stability", "-2", "", "", "Stability", "2", "", "", "Stability", "2", "", "", "Stability", "-2", "", ""], ["4", "COUNTRY1 is reported to be further developing their nuclear weapons program. You may give them sanctions, but this will greatly affect their military and stability.", "RANDOM", "", "Give Immediate Sanctions", "Ignore All Reports", "Military", "-3", "Stability", "-3", "", "", "", "", "Military", "3", "NuclearProgress", "", "", "", "", ""], ["5", "Citizens of COUNTRY1 who live at the border have been crossing the into COUNTRY2 to access better healthcare services. COUNTRY2 argues that this is adding more trouble to their already clogged healthcare system, while COUNTRY1 argues that they are legally crossing and properly paying for their services.", "RANDOM", "RANDOM", "Favor COUNTRY1", "Favor COUNTRY2", "Stability", "2", "", "", "Stability", "-1", "Cooperation", "-2", "Stability", "-1", "Cooperation", "-1", "Stability", "2", "", ""], ["6", "COUNTRY1 is complaining about the military excercises COUNTRY2 is doing close to their border. COUNTRY1 wants these exercises to be moved farther away, while COUNTRY2 argues that they have a right to use their land how they see fit.", "RANDOM", "RANDOM", "Favor COUNTRY1", "Favor COUNTRY2", "Stability", "1", "Cooperation", "1", "Military", "-2", "Cooperation", "-1", "Stability", "-1", "Cooperation", "-2", "Military", "3", "", ""], ["7", "COUNTRY1’s potato exports have been greatly impaired due to rebels. COUNTRY2, who imports most of their potatoes from COUNTRY1, offers to help get rid of these rebels in exchange for giving them potato discounts. COUNTRY1 says that they can handle the problem themselves.", "RANDOM", "RANDOM", "Accept Proposal", "Reject Proposal", "Economy", "-1", "Stability", "1", "Economy", "1", "Cooperation", "1", "Economy", "1", "Military", "-1", "Economy", "-1", "Cooperation", "-1"], ["8", "The rapidly developing nation of COUNTRY1 has been investing heavily in infrastructure projects, but has run out of budget to fit all of their plans. COUNTRY2 offers aid, in exchange for being granted part ownership of these projects as repayment.", "RANDOM", "RANDOM", "Support Offer", "Deny Offer", "Economy", "3", "Stability", "-3", "Cooperation", "2", "Economy ", "-1", "Economy", "-1", "Stability", "1", "Cooperation", "-1", "", ""], ["9", "COUNTRY1 has issued a travel ban for COUNTRY2 to their citizens, citing recent events of COUNTRY2 forcing COUNTRY1’s minority groups in the country to leave. With most of their tourism coming from COUNTRY1, COUNTRY2 argues that these groups were housing dangerous rebel groups that are a threat to their nation\'s security.", "RANDOM", "RANDOM", "Uphold Travel Ban", "Overturn Travel Ban", "Stability ", "2", "Cooperation", "1", "Economy", "-2", "Cooperation", "-1", "Stability", "-2", "Cooperation", "-2", "Economy", "1", "Cooperation", "1"], ["10", "As one of their requirements for peace, COUNTRY1 requires COUNTRY2 to admit their war crimes during the last Great War. Despite numerous evidence against them, COUNTRY2 refuses to acknowledge that those events ever happened.", "RANDOM", "RANDOM", "War Crimes Admitted", "Cover Up Crimes", "Cooperation", "2", "", "", "Cooperation", "-3", "", "", "Cooperation", "-3", "", "", "Cooperation", "2", "", ""], ["11", "Cheap products from COUNTRY2 is greatly affecting COUNTRY1’s economy, as their own products cannot compete against COUNTRY2’s lower prices. Due to this, COUNTRY1 is considering banning a significant portion of trade from COUNTRY2.", "RANDOM", "RANDOM", "Implement Trade Restrictions", "Deny Trade Ban", "Economy", "1", "Cooperation", "1", "Economy", "-2", "", "", "Economy", "-2", "", "", "Economy", "1", "", ""]]

var current_event: Array = []

func _ready() -> void:
	SignalHandler.connect("event_option_selected", Callable(self, "event_option_selected"))
	SignalHandler.connect("new_event_requested", Callable(self, "new_event_requested"))
	SignalHandler.connect("request_specific_event", Callable(self, "request_specific_event"))
	initialize_events()

func initialize_events() -> void:
	#var event_file: FileAccess = FileAccess.open("res://misc/event_spreadsheet.csv", FileAccess.READ)
	#while !event_file.eof_reached():
		#var event_rows: PackedStringArray = event_file.get_csv_line(",")
		#events.append(event_rows)
	#events.pop_front()
	#events.pop_back()
	#event_file.close()
	pass

func generate_new_event() -> void:
	var event_id: int = randi_range(0, events.size() - 1)
	current_event = events[event_id]
	if current_event[2] == "RANDOM":
		current_event[2] = countries.pick_random()
	if current_event[3] == "RANDOM":
		current_event[3] = countries.pick_random()
		while current_event[3] == current_event[2]:
			current_event[3] = countries.pick_random()
	SignalHandler.emit_signal("event_generated", current_event[1], current_event[2], current_event[3], current_event[4], current_event[5])

func event_option_selected(option: int) -> void:
	if current_event:
		match option:
			1:
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[6], current_event[7].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[8], current_event[9].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[10], current_event[11].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[12], current_event[13].to_int())
			2:
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[14], current_event[15].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[16], current_event[17].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[18], current_event[19].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[20], current_event[21].to_int())

func new_event_requested() -> void:
	generate_new_event()

func request_specific_event(event_id: int) -> void:
	current_event = events[event_id]
	if current_event[2] == "RANDOM":
		current_event[2] = countries.pick_random()
	if current_event[3] == "RANDOM":
		current_event[3] = countries.pick_random()
		while current_event[3] == current_event[2]:
			current_event[3] = countries.pick_random()
