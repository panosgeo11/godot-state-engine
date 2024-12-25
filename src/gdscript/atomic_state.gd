@icon("res://assets/editor/state-engine/atomic_state.svg")
class_name AtomicState extends State

func _ready() -> void:
    # Forbid Atomic State from having children nodes.
    assert(get_child_count() == 0, "Children found in AtomicState " + name + ". Atomic States cannot have children.")
