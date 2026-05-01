extends Resource
class_name SingleInput

var stored_input : Dictionary
# Add in charged later.
var charged : bool = false

var used_for = ""

@export_enum("LEFT","RIGHT","UP","DOWN","UPLEFT","UPRIGHT","DOWNLEFT","DOWNRIGHT","NEU") var stick_dir = "NEU"

# - means negative edge, only possible with negative press. + means dual edge, possible with release and press.
# "+" Only for commands.

@export_enum("A","B","AB","NEU","-A","-B","-AB","+A","+B","+AB") var button_press = "NEU"


func check_stored_equality(alternate_single : SingleInput):
	
	var alternate_input = alternate_single.stored_input
	
	if not (stored_input["Stick_Horizontal"] == alternate_input["Stick_Horizontal"]):
		return false
	
	if not (stored_input["Stick_Vertical"] == alternate_input["Stick_Vertical"]):
		return false
	
	var button_a_original = stored_input["Button_A"]
	var button_b_original = stored_input["Button_B"]
	var button_a_alt = alternate_input["Button_A"]
	var button_b_alt = alternate_input["Button_B"]
	
	
	if button_a_original == 1 or button_a_original == 2:
		button_a_original = 1
	
	if button_b_original == 1 or button_b_original == 2:
		button_b_original = 1
	
	if button_a_alt == 1 or button_a_alt == 2:
		button_a_alt = 1
	
	if button_b_alt == 1 or button_b_alt == 2:
		button_b_alt = 1
	
	if button_a_original == 0 or button_a_original == -1:
		button_a_original = 0
	
	if button_b_original == 0 or button_b_original == -1:
		button_b_original = 0
	
	if button_a_alt == 0 or button_a_alt == -1:
		button_a_alt = 0
	
	if button_b_alt == 0 or button_b_alt == -1:
		button_b_alt = 0
	
	
	
	
	
	if not (button_a_original == button_a_alt):
		return false
	
	if not (button_b_original == button_b_alt):
		return false
	
	
	
	return true

func _init(input = "MANUAL") -> void:
	
	
	pass
	if typeof(input) == TYPE_STRING:
		pass
	else:
		stored_input = input
		return
	
	#if stick_direction == "":
	#	stick_dir = stick_direction
	#	button_press = buttons_pressed
	
	
	_ready.call_deferred()
	
	# Interpret from thing.

func _ready():
	
	if stick_dir != "" and button_press != "":
		stored_input = return_dict_from_name(stick_dir,button_press)
	else:
		return


func return_dict_from_name(stick_string : String, button_string : String):
	var inputs_check = ["Stick_Horizontal","Stick_Vertical","Button_A","Button_B"]
	var inputs = {}
	
	match stick_string:
		"NEU":
			inputs.set(inputs_check[0],0)
			inputs.set(inputs_check[1],0)
		"LEFT":
			inputs.set(inputs_check[0],-1)
			inputs.set(inputs_check[1],0)
		"RIGHT":
			inputs.set(inputs_check[0],1)
			inputs.set(inputs_check[1],0)
		"UP":
			inputs.set(inputs_check[0],0)
			inputs.set(inputs_check[1],1)
		"DOWN":
			inputs.set(inputs_check[0],0)
			inputs.set(inputs_check[1],-1)
		"UPLEFT":
			inputs.set(inputs_check[0],-1)
			inputs.set(inputs_check[1],1)
		"UPRIGHT":
			inputs.set(inputs_check[0],1)
			inputs.set(inputs_check[1],1)
		"DOWNLEFT":
			inputs.set(inputs_check[0],-1)
			inputs.set(inputs_check[1],-1)
		"DOWNRIGHT":
			inputs.set(inputs_check[0],1)
			inputs.set(inputs_check[1],-1)
	
	match button_string:
		"NEU":
			inputs.set(inputs_check[2],0)
			inputs.set(inputs_check[3],0)
		"A":
			inputs.set(inputs_check[2],1)
			inputs.set(inputs_check[3],0)
		"B":
			inputs.set(inputs_check[2],0)
			inputs.set(inputs_check[3],1)
		"AB":
			inputs.set(inputs_check[2],1)
			inputs.set(inputs_check[3],1)
		"-A":
			inputs.set(inputs_check[2],-1)
			inputs.set(inputs_check[3],0)
		"-B":
			inputs.set(inputs_check[2],0)
			inputs.set(inputs_check[3],-1)
		"-AB":
			inputs.set(inputs_check[2],-1)
			inputs.set(inputs_check[3],-1)
		"+A":
			inputs.set(inputs_check[2],2)
			inputs.set(inputs_check[3],0)
		"+B":
			inputs.set(inputs_check[2],0)
			inputs.set(inputs_check[3],2)
		"+AB":
			inputs.set(inputs_check[2],2)
			inputs.set(inputs_check[3],2)
	
	
	
	
	return inputs
