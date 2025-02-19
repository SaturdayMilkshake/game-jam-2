extends Node

@warning_ignore("unused_signal")
signal new_turn(turn: int)

@warning_ignore("unused_signal")
signal country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int)
@warning_ignore("unused_signal")
signal modify_country_value(country: String, attribute: String, modifier: int)

@warning_ignore("unused_signal")
signal new_event_requested
@warning_ignore("unused_signal")
signal event_generated(description: String, country_1: String, country_2: String, option_1: String, option_2: String)


@warning_ignore("unused_signal")
signal event_option_selected(option: int)
