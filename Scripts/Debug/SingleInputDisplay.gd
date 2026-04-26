extends Control
class_name SingleInputDisplay

@export var single_input : SingleInput

@onready var atlas_texture : AtlasTexture = preload("res://AtlasTexture/InputDisplay.atlastex")
# Parse the input into a set of em.

var Sprite_Pick = {"PUNCH" : Vector2(0,0), "KICK" : Vector2(10,0),
"EX" : Vector2(20,0), "RIGHT" : Vector2(0,10), "LEFT" : Vector2(10,10),
"UP" : Vector2(20,10), "DOWN" : Vector2(0,20),
"UPRIGHT" : Vector2(10,20),
"UPLEFT" : Vector2(20,20),
"DOWNLEFT" : Vector2(0,30),
"DOWNRIGHT" : Vector2(10,30),
"CROSSED" : Vector2(20,30)}

var Vector_Name = {"LEFT" : Vector2(-1,0),
"RIGHT" : Vector2(1,0),
"UP" : Vector2(0,1),
"DOWN" : Vector2(0,-1),
"UPLEFT" : Vector2(-1.0,1.0),
"UPRIGHT" : Vector2(1.0,1.0),
"DOWNLEFT" : Vector2(-1.0,-1.0),
"DOWNRIGHT" : Vector2(1.0,-1.0)}

var atlas_node = TextureRect.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if single_input.stored_input == {}:
		await get_tree().process_frame
	
	
	get_stick_direction()
	get_button_pressed()
	
	if single_input.used_for != "":
		modulate.b = 0
		modulate.g = 0
	

func get_stick_direction():
	var horizontal = single_input.stored_input["Stick_Horizontal"]
	var vertical = single_input.stored_input["Stick_Vertical"]
	var stick_vector = Vector2(horizontal,vertical)
	if stick_vector == Vector2.ZERO:
		return
	var stick_name = Vector_Name.find_key(round(stick_vector))
	
	var sprite_offset = Sprite_Pick[stick_name]
	add_input_display(sprite_offset)

func get_button_pressed():
	var a = single_input.stored_input["Button_A"]
	var b = single_input.stored_input["Button_B"]
	
	if a == 1:
		add_input_display(Sprite_Pick["PUNCH"])
	
	if b == 1:
		add_input_display(Sprite_Pick["KICK"])

func add_input_display(sprite_offset):
	var child_atlas_node : TextureRect = TextureRect.new()
	
	# issue with region
	child_atlas_node.texture = atlas_texture.duplicate()
	child_atlas_node.texture.region.position.x = sprite_offset.x
	child_atlas_node.texture.region.position.y = sprite_offset.y
	$InputsToDisplay.add_child(child_atlas_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
