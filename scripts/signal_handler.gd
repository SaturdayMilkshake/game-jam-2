extends Node

@warning_ignore("unused_signal")
signal new_turn
@warning_ignore("unused_signal")
signal turn_updated(turn: int)

@warning_ignore("unused_signal")
signal country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int)
@warning_ignore("unused_signal")
signal modify_country_value(country: String, attribute: String, modifier: int)

@warning_ignore("unused_signal")
signal new_event_requested
@warning_ignore("unused_signal")
signal event_generated(description: String, country_1: String, country_2: String, option_1: String, option_2: String)

signal new_notice(description: String)

@warning_ignore("unused_signal")
signal event_option_selected(option: int)

@warning_ignore("unused_signal")
signal set_event_info_visibility(status: int)

@warning_ignore("unused_signal")
signal finished_all_events_this_turn

@warning_ignore("unused_signal")
signal game_started

#resources
signal influence_updated(influence: int)

#special event
signal peace_process_started
