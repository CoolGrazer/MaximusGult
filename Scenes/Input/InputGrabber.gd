extends Node
class_name InputGrabber
# Underdrive.

var player_type : String = ""

var player_name = ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	match player_type:
		"Player1":
			player_name = "P1"
		"Player2":
			player_name = "P2"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if get_parent() != null:
		
		get_parent().add_input_dict(get_input_dict())
	

func get_input_dict() -> SingleInput:
	
	var inputs_check = ["Stick_Horizontal","Stick_Vertical","Button_A","Button_B"]
	
	var inputs = {}
	for input in inputs_check:
		var input_grabbed : int = 0
		if input.begins_with("Stick_"):
			input_grabbed = directional_input_cleaner(input)
			
		if input.begins_with("Button_"):
			
			input_grabbed = button_interpreter(input)
			
		inputs.set(input,input_grabbed)
	
	
	# SOCD Neutral. (L+R=N)
	
	return SingleInput.new(inputs)

func button_interpreter(button_type) -> int:
	var button_state : int = 0
	match button_type:
		"Button_A":
			if Input.is_action_just_pressed(player_name + "A"):
				button_state = 1
			if Input.is_action_just_released(player_name + "A"):
				button_state = -1
		"Button_B":
			if Input.is_action_just_pressed(player_name + "B"):
				button_state = 1
			if Input.is_action_just_released(player_name + "B"):
				button_state = -1
	
	return button_state

func directional_input_cleaner(axis_direction,type_of_cleaner = "N") -> int:
	# Both -1 and 1 are present on stick axis, forcing system to make a decision.
	var axis : int = 0
	var lock_counter : int = 0
	
	match axis_direction:
		"Stick_Horizontal":
			
			if Input.is_action_pressed(player_name + "Left"):
				
				axis = -1
				lock_counter += 1
			if Input.is_action_pressed(player_name + "Right"):
				axis = 1
				lock_counter += 1
		"Stick_Vertical":
			if Input.is_action_pressed(player_name + "Down"):
				axis = -1
				lock_counter += 1
			if Input.is_action_pressed(player_name + "Up"):
				axis = 1
				lock_counter += 1
	
	
	if lock_counter == 2:
		match type_of_cleaner:
			"N":
				axis = 0
			"P":
				axis = 1
			"N":
				axis = -1
		
	
	return axis
