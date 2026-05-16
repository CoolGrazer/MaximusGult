extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State

var all_states : Array[State]

# Create change state function.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for state : State in get_children():
		state.playable_fighter = get_parent()
		state.state_machine = self
		all_states.append(state)
	
	initial_state._enter()
	current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state._update()
	

func change_state_name(state_name : String):
	for named_state in all_states:
		if named_state.name == state_name:
			change_state_node(named_state)
			return

func change_state_node(new_state):
	current_state._exit()
	new_state._enter()
	current_state = new_state
