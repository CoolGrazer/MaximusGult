@tool

extends Node2D
class_name FightingStage
@export_file() var background_nodes

@export var ground_y_level : int = 0
@export_range(0,1) var horizontal_spawn_distance = 0.0


func _draw() -> void:
	
	
	var left : Vector2 = to_local(Vector2(-1984,ground_y_level))
	var right : Vector2 = to_local(Vector2(1984,ground_y_level))
	
	draw_dashed_line(left,right,Color.RED,0)
	if Engine.is_editor_hint():
		editor_specific_draw_code()

func _process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		queue_redraw()

func editor_specific_draw_code():
	pass
	var left : Vector2 = to_local(Vector2(-1984,ground_y_level))
	var right : Vector2 = to_local(Vector2(1984,ground_y_level))
	
	draw_dashed_line(left,right,Color.RED)
