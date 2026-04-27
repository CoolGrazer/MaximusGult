extends Node



var input_buffer : InputString = InputString.new()

@export var input_buffer_length : int = 50
@export var max_frames_for_double_taps : int = 30

@export_enum("Player1","Player2") var player_name = ""

@export var moves_to_check : Array[GenericInputCommand]


var moves_avalible_to_input : Array[GenericInputCommand]

signal move_inputed(move : String)
signal export_input_buffer(buffer : InputString)
signal most_recent_input(single_input : SingleInput)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$InputGrabber.player_type = player_name

# Create visualizer for move buffer.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	moves_avalible_to_input = []
	
	for i : GenericInputCommand in moves_to_check:
		if i.get_progress_from_input_buffer(input_buffer) != null:
			moves_avalible_to_input.append(i)
	
	var final_move : GenericInputCommand
	var current_priority_type = "Command_Normal"
	var current_priority_granular = ""
	for move : GenericInputCommand in moves_avalible_to_input:
		
		if move.priority_type == "Command_Normal" and current_priority_type == "Command_Normal":
			final_move = move
		if move.priority_type == "Specials":
			current_priority_type = "Specials"
			
			var button_to_press = move.special_super_button
			var stored_value = input_buffer.string[-1].stored_input[button_to_press]
			
			if abs(stored_value) > 0:
				final_move = move
			
	
	if final_move != null:
		final_move.command_inputted()
	
	if input_buffer.string.size() == 0:
		return
	
	emit_signal("most_recent_input",input_buffer.string[-1])
	emit_signal("export_input_buffer",input_buffer)



func add_input_dict(input : SingleInput):
	input_buffer.string.append(input)
	
	
	
	if input_buffer.string.size() > input_buffer_length:
		input_buffer.string.remove_at(0)
