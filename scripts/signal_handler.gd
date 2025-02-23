extends Node

@warning_ignore("unused_signal")
signal new_turn
@warning_ignore("unused_signal")
signal turn_updated(turn: int)

@warning_ignore("unused_signal")
signal country_selected(country: String, flag: String, population: int, economy: int, stability: int, military: int, cooperation: int, statuses: String)
@warning_ignore("unused_signal")
signal update_country_info(country: String)
@warning_ignore("unused_signal")
signal modify_country_value(country: String, attribute: String, modifier: int)

@warning_ignore("unused_signal")
signal new_event_requested
@warning_ignore("unused_signal")
signal event_generated(description: String, country_1: String, country_2: String, option_1: String, option_2: String)

@warning_ignore("unused_signal")
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
@warning_ignore("unused_signal")
signal influence_updated(influence: int)
@warning_ignore("unused_signal")
signal influence_used(country: String, attribute: String, add_mode: bool)

#special event
@warning_ignore("unused_signal")
signal peace_process_started

signal update_global_status(status: String, amount: int)

#country attribute statuses
signal no_economy
signal excess_economy
signal no_stability
signal no_military
signal no_cooperation
signal excess_military
signal excess_cooperation

signal game_over(reason: String)
signal game_ended

signal add_influence(amount: int)

#transition
signal transition_requested(fade_in: bool, target: String)

#events
signal request_specific_event(event_id: int)

#tutorial
signal display_notice_info(display_immediately: bool, source: String)
signal set_country_info_tutorial_status(status: bool)
