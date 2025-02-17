extends Node

@warning_ignore("unused_signal")
signal new_turn(turn: int)

@warning_ignore("unused_signal")
signal country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int)
@warning_ignore("unused_signal")
signal modify_country_value(country: String, attribute: String, modifier: int)

@warning_ignore("unused_signal")
signal generate_new_event
