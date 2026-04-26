extends Node2D
class_name Fighter
var current_input : SingleInput


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_interpreter_most_recent_input(single_input: SingleInput) -> void:
	current_input = single_input
