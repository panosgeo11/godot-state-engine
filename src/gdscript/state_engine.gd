@icon("res://assets/editor/state-engine/state_engine.svg")
class_name StateEngine extends Node

var _root_state: State  # Sole child root State of the StateEngine.

func _ready() -> void:
    assert(
        get_child_count() == 1,
        "StateEngine should have exactly one child Node of type State."
    )

    _root_state = get_child(0)
    _root_state.on_enter()

func _process(delta: float) -> void:
    _root_state.update_frames(delta)

func _physics_process(delta: float) -> void:
    _root_state.update_physics(delta)
