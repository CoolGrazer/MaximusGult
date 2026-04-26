extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State

# Create change state function.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for state : State in get_children():
		state.playable_fighter = get_parent()
		state.state_machine = self
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
