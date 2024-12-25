@icon("res://assets/editor/state-engine/composite_state.svg")
class_name CompositeState extends State

@export var _initial_substate: State  # State which this CompositeState activates when directly transitioned into.

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
        "CompositeState " + name + " has no substates. CompositeStates should have at least one substate."
    )

    if get_child_count() < 1:
        push_warning("CompositeState " + name + " has only one substate. It is best to add another substate, or go with an AtomicState instead.")
    
    for substate: State in get_children():
        _substates[substate.name] = substate
        substate.transitioned.connect(_change_state)
    
    assert(
        _initial_substate in _substates.values(),
        "Set initial substate" + _initial_substate.name + " is no substate of CompositeState " + name + "."
    )

    if _initial_substate == null:
        _initial_substate = get_child(0)

func on_enter() -> void:
    _initial_substate.on_enter()
    _current_substate = _initial_substate

func update_frames(delta: float) -> void:
    _current_substate.update_frames(delta)

func update_physics(delta: float) -> void:
    _current_substate.update_physics(delta)

func on_exit() -> void:
    _current_substate.on_exit()
    _current_substate = null

func _change_state(from_substate: State, to_substate_name: String) -> void:
    assert(
        from_substate == _current_substate,
        "Invalid substate transition, trying from " + from_substate.name + " state but currently in " + _current_substate.name + "."
    )

    assert(
        _substates.has(to_substate_name),
        "Target substate " + to_substate_name + " does not exist."
    )

    var to_substate: State = _substates[to_substate_name]

    if to_substate.can_enter():
        _current_substate.on_exit()
        to_substate.on_enter()
        _current_substate = to_substate
