extends Resource
class_name CharacterProperties

@export_category("Name")
@export var character_name : String

@export_category("Sprite Information")
@export_group("Sprite Data")
@export var sprite_texture : Texture
@export var frames_v : int = 1
@export var frames_h : int = 1

@export_category("Movement Information")
@export_group("Basic Movement Data")
@export_subgroup("Ground Movement")
@export var forward_walk_speed_subpixels : int = 0
@export var backward_walk_speed_subpixels : int = 0
@export_subgroup("Jumping Movement")
@export var jump_height : int = 0
@export var time_to_jump : int = 0
@export var time_to_land : int = 0
@export_subgroup("Lag Time Movement")
@export var crouch_jump_lag : int = 0
@export var crouch_land_lag : int = 0

@export_category("General InteractBoxes")
@export_group("InteractBox Data")
@export_subgroup("Push Boxes")
@export var push_box_width : int = 0
@export var push_box_height : int = 0
@export_subgroup("Grab Boxes")
@export var grab_box_width : int = 0
@export var grab_box_height : int = 0
