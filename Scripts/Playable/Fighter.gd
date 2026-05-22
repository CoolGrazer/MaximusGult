extends Node2D

class_name Fighter

@export var character_properties : CharacterProperties

@export var animation_testing : bool = false

var current_input : SingleInput = SingleInput.new()
var current_position : FightPos = FightPos.new()

var enemy_facing_direction : int = 1

@onready var fighting_stage : FightingStage

@onready var sprite_node : Sprite2D = get_node("FighterSprite")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("AnimationPlayer").animation_data = character_properties.animation_data
	current_position.set_pixel_values(position)
	set_up_sprite_work()
	if animation_testing == true:
		pass
	else:
		fighting_stage = get_parent()
		spawn_in()

func set_up_sprite_work():
	sprite_node.texture = character_properties.sprite_texture
	sprite_node.hframes = character_properties.frames_h
	sprite_node.vframes = character_properties.frames_v

func spawn_in():
	var x_position : int = 80 - (fighting_stage.horizontal_spawn_distance * 80)
	
	current_position.set_pixel_values(Vector2(x_position,fighting_stage.ground_y_level))
	position = current_position.pixel_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position = current_position.pixel_position
	
	
	
	position = current_position.pixel_position


func _on_input_interpreter_most_recent_input(single_input: SingleInput) -> void:
	current_input = single_input
