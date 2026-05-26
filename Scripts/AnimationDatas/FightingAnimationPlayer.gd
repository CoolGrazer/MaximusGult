extends Node
class_name FightingAnimationPlayer

@export var animation_data : Dictionary[String,FullAnimationData]

var current_animation : FullAnimationData

var current_animation_cell : AnimationCell

var animation_cells_left : int = 0

var duration_of_cell : int = 0

@onready var affected_fighter : Fighter = get_parent()

func _ready() -> void:
	await get_tree().process_frame
	start_animation("Idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("P1A"):
		start_animation("Idle")
	if Input.is_action_just_pressed("P1B"):
		affected_fighter.current_position.set_pixel_values(Vector2(72,88))


func start_animation(animation_name :String) -> String:
	var found_animation = animation_data[animation_name]
	if found_animation == null:
		return "Error does not exist."
	current_animation = found_animation
	set_to_initial_animation_state()
	while animation_cells_left > 0:
		
		
		if current_animation_cell.constant_frame_displacement.length() > 0.:
			var current_duration_left : float = duration_of_cell
			var current_distance = (current_animation_cell.duration_of_cell - current_duration_left) / current_animation_cell.duration_of_cell
			var last_distancce = (current_animation_cell.duration_of_cell - current_duration_left) / current_animation_cell.duration_of_cell
			var sampled_value = current_animation_cell.constant_frame_displacement_curve.sample(current_distance)
			var last_sample = current_animation_cell.constant_frame_displacement_curve.sample(last_distancce)
			print(sampled_value)
			var constant_displacement = current_animation_cell.constant_frame_displacement * (sampled_value)
			affected_fighter.current_position.move_whole_pixels(constant_displacement)
		
		
		if duration_of_cell == 0:
			animation_cells_left -= 1
			if animation_cells_left == 0:
				continue
			
			
			var current_animation_cell_index = current_animation.animation_cells.size() - animation_cells_left
			current_animation_cell = current_animation.animation_cells[current_animation_cell_index]
			animation_cell_update()
			
		
		
		
		
		duration_of_cell -= 1
		
		await get_tree().process_frame
	
	
	return "Animation Completed!"





func set_to_initial_animation_state():
	animation_cells_left = current_animation.animation_cells.size()
	current_animation_cell = current_animation.animation_cells[0]
	animation_cell_update()
	

func animation_cell_update():
	duration_of_cell = current_animation_cell.duration_of_cell
	affected_fighter.sprite_node.frame = current_animation_cell.character_frame
	affected_fighter.current_position.move_whole_pixels(current_animation_cell.inital_frame_displacement)

func cancel_animation_into():
	pass
