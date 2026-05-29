extends State


func _enter():
	pass

func _update():
	walk(playable_fighter.current_input.stored_input["Stick_Horizontal"])



func walk(walk_direction):
	var look_direction = playable_fighter.enemy_facing_direction
	var movement_distance = 0
	if look_direction == walk_direction:
		movement_distance = playable_fighter.character_properties.forward_walk_speed_subpixels
	elif look_direction == -walk_direction:
		movement_distance = playable_fighter.character_properties.backward_walk_speed_subpixels
	else:
		state_machine.change_state_name("Idle")
	
	playable_fighter.current_position.move_stepped_sub_pixels(Vector2(movement_distance * walk_direction,0))
	
