extends Resource
class_name GenericInputCommand

@export var priority_type = Attack_Priorities.Priorities.BASIC

@export var move_name = ""

@export var input_string : InputString

@export var priority_beater = Attack_Priorities.Priority_Beater.THROW_OUT

@export_enum("Button_A","Button_B") var special_super_button : String = ""

@export var EX_Possible : bool = false

var search_back_multi_press : int = 3
# Input Leniency. I mean, Downright is BASICALLY just Right, right?
# Three types. Command Normals. Specials, and Supers.
# "A grab should technically be a special."

var progress = 0
var max_needed = 0
var inputs_raw = []
var previous_move_buffer = []

var current_input : SingleInput

var inputs_used = []

# Called when the node enters the scene tree for the first time.

func command_inputted():
	
	for input in inputs_used:
		input.used_for = move_name
	inputs_used = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_progress_from_input_buffer(input_buffer : InputString):
	
	inputs_raw = input_buffer.string
	
	max_needed = input_string.string.size()
	
	progress = 0
	
	for input : SingleInput in inputs_raw:
		current_input = input
		
		if input.used_for == move_name:
			
			continue
		
		
		## Fix multipress.
		var current_input_required : SingleInput = input_string.string[progress]
		var multi_press : bool = false
		# Check if multi-press. If so, provide leniency. We're not doing frame 1's over fucking here.
		if current_input_required.stored_input["Button_A"] != 0 and current_input_required.stored_input["Button_B"] != 0:
			multi_press = true
			
		# Direction and input at same time, provide leniency.
		if multi_press and authenticate_stick_direction(input,current_input_required):
			
			var input_index = inputs_raw.find(input)
			previous_move_buffer = range(input_index - search_back_multi_press, input_index)
			
			check_previous_button_buffers(input)
			
			if progress == max_needed:
				return move_name
			continue
		
		if input.stored_input == current_input_required.stored_input:
			
			add_progress()
			
			if progress == max_needed:
				
				return move_name
			continue
		else:
			continue
	
	
	
	return null

func authenticate_stick_direction(input,current_input_required):
	if input.stored_input["Stick_Horizontal"] == current_input_required.stored_input["Stick_Horizontal"]:
		pass
	else:
		return false
	if input.stored_input["Stick_Vertical"] == current_input_required.stored_input["Stick_Vertical"]:
		pass
	else:
		return false
	return true

func add_progress():
	progress += 1
	
	inputs_used.append(current_input)

func check_previous_button_buffers(input):
	if previous_button_buffer("Button_A",input) == true: return
	previous_button_buffer("Button_B",input)

func previous_button_buffer(button_to_search,input):
	var other_button = ""
	if button_to_search == "Button_A":
		other_button = "Button_B"
	if button_to_search == "Button_B":
		other_button = "Button_A"
	if input.stored_input[button_to_search] == 1:
		for checked_input_index in previous_move_buffer:
			if inputs_raw[checked_input_index].stored_input[other_button] == 1:
				
				if inputs_raw[checked_input_index].used_for == move_name:
					return false
				
				inputs_used.append(inputs_raw[checked_input_index])
				add_progress()
				return true
	
	return false
