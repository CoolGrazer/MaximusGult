extends Node2D
class_name Fighter

@export var character_properties : CharacterProperties

var current_input : SingleInput
var current_position : FightPos = FightPos.new()

var enemy_facing_direction : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	position = current_position.pixel_position


func _on_input_interpreter_most_recent_input(single_input: SingleInput) -> void:
	current_input = single_input
