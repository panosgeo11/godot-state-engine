# Godot State Engine
State Machine implementation for the Godot game engine.

## Motivation
When developing my games in Godot, I frequently use finite state machines to organize the logic of different aspects of my games. However, finite state machines typically allow for only one state to be active at a given time, which is sometimes limiting for my needs.

Thus, I was inspired by Harel Statecharts to code my own form of an advanced state machine, featuring both state hieararchy and parallelism. To give it a cool theme, I was also inspired by car transmissions to symbolize the components of the state machine, which I affectionally named State Engine.

This code is tailored to my needs, but I thought that other people may find use for it.

## Classes (Godot Nodes)
- StateEngine: The main node that executes the various state behaviors inside the appropriate godot node overrides. Is themed after a car engine/transmission (engine sounds cooler).
- State: The base State class from which all other state types inherit. States are allowed to have substates.
- CompositeState: Traditional state machine that executes only one of its substates. Is themed after a gear shift, with each substate being a different gear ratio.
- ParallelState: Concurrent state machine that executes all of its substates simultaneously. Is themed after meshing gears because they all spin together.
- AtomicState: Simple state that is not allowd to have substates. Is themed after a single gear.

## Language Support
State Engine is written in both GDScript and C#, as I frequently use both for various projects, depending on their scope.

## TODO
- General polishing.
- Make it an addon.
