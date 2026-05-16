extends State


# Called when the node enters the scene tree for the first time.
func  _enter():
	pass

func _update():
	if playable_fighter.current_input.stored_input["Stick_Horizontal"] != 0:
		pass
	else:
		state_machine.change_state_name("Walking")
	

func _exit():
	pass
