extends Resource
class_name FightPos


var sub_pixel_position : Vector2i
var pixel_position : Vector2i



const sub_pixel_resolution : int = 16


func move_whole_pixels(vector : Vector2i):
	sub_pixel_position += vector * sub_pixel_resolution
	
	update_all_values()

func move_stepped_sub_pixels(vector : Vector2i):
	sub_pixel_position += vector
	
	update_all_values()


func update_all_values():
	pixel_position = Vector2(sub_pixel_position) / 16.
