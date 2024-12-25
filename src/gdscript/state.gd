class_name State extends Node

signal transitioned(from_state: State, to_state_name: String)

func can_enter() -> bool:
    return true

func on_enter() -> void:
    pass

func update_frames(_delta: float) -> void:
    pass

func update_physics(_delta: float) -> void:
    pass

func on_exit() -> void:
    pass

func transition_to(next_state_name: String) -> void:
    transitioned.emit(self, next_state_name)