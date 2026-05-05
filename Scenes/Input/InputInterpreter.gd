extends Node



var input_buffer : InputString = InputString.new()

@export var input_buffer_length : int = 50
@export var max_frames_for_double_taps : int = 30

@export_enum("Player1","Player2") var player_name = ""

@export var moves_to_check : Array[GenericInputCommand]



var moves_avalible_to_input : Array[GenericInputCommand]

signal move_inputed(move : GenericInputCommand)
signal export_input_buffer(buffer : InputString)
signal most_recent_input(single_input : SingleInput)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$InputGrabber.player_type = player_name

# Create visualizer for move buffer.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	moves_avalible_to_input = []
	
	for move : GenericInputCommand in moves_to_check:
		if move.get_progress_from_input_buffer(input_buffer) != null:
			
			if move.priority_type >= Attack_Priorities.Priorities.SPECIALS:
				var button_to_press = move.special_super_button
				var stored_value = input_buffer.string[-1].stored_input[button_to_press]
				print(stored_value)
				if abs(stored_value) == 1:
					move.inputs_used.append(input_buffer.string[-1])
					moves_avalible_to_input.append(move)
			else:
				moves_avalible_to_input.append(move)
			
			
	
	
	if moves_avalible_to_input.size() > 0:
		check_for_final_move()
	
	
	
	if input_buffer.string.size() == 0:
		return
	
	emit_signal("most_recent_input",input_buffer.string[-1])
	emit_signal("export_input_buffer",input_buffer)



func check_for_final_move():
	var final_move : GenericInputCommand = moves_avalible_to_input[0]
	for move : GenericInputCommand in moves_avalible_to_input:
		
		if final_move.priority_type > move.priority_type:
			continue
		
		if final_move.priority_type < move.priority_type:
			final_move = move
		
		if final_move.priority_type == move.priority_type:
			if final_move.priority_beater > move.priority_beater:
				continue
			else:
				final_move = move
		
	
	if final_move != null:
		final_move.command_inputted()
		emit_signal("move_inputed",final_move)
		print("Inpouted.")

func add_input_dict(input : SingleInput):
	input_buffer.string.append(input)
	
	
	
	if input_buffer.string.size() > input_buffer_length:
		input_buffer.string.remove_at(0)
