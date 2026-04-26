extends State


# Called when the node enters the scene tree for the first time.
func  _enter():
	pass

func _update():
	if playable_fighter.current_input["Horizontal"] != 0:
		state_machine.current_state

func _exit():
	pass
