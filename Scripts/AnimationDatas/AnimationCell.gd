extends Resource
class_name AnimationCell
@export var duration_of_cell : int = 0

@export var character_frame : int = 0

@export var inital_frame_displacement : Vector2 = Vector2.ZERO
@export var constant_frame_displacement : Vector2 = Vector2.ZERO
@export var constant_frame_displacement_curve : Curve = Curve.new()

#@export var force_activation : Vector2 = Vector2.ZERO


var progress_through_data : int = 0





#@export var hurtboxes_present : Array[Hurtboxes]
#@export var hitboxes_present : Array[Hitboxes]

#@export var character_state : Array[CharacterState]
