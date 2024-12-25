@icon("res://assets/editor/state-engine/parallel_state.svg")
class_name ParallelState extends State

var _current_substate: State
var _substates: Dictionary = {}

func _ready() -> void:
    for child in get_children():
        assert(
            child is State, 
            "Non-State child has been found. Do not pollute the StateEngine."
        )

    assert(
        get_child_count() > 0, 
        "ParallelState " + name + " has no substates. ParallelStates should have at least one substate."
    )

    if get_child_count() < 1:
        push_warning("ParallelState " + name + " has only one substate. It is best to add another substate, or go with an AtomicState instead.")
    
    for substate: State in get_children():
        _substates[substate.name] = substate
    
func on_enter() -> void:
    for substate: State in _substates.values():
        substate.on_enter()

func update_frames(delta: float) -> void:
    for substate: State in _substates.values():
        substate.update_frames(delta)

func update_physics(delta: float) -> void:
    for substate: State in _substates.values():
        substate.update_physics(delta)

func on_exit() -> void:
    for substate: State in _substates.values():
        substate.on_exit()
