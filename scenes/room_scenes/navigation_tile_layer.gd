extends TileMapLayer

@onready var top_walls: TileMapLayer = $"../top walls"
@onready var bottom_walls: TileMapLayer = $"../bottom walls"
@onready var furniture_map: TileMapLayer = $"../Furniture map"

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in top_walls.get_used_cells_by_id(0):
		return true
	if coords in bottom_walls.get_used_cells_by_id(0):
		return true
	if coords in furniture_map.get_used_cells_by_id(0):
		return true
	return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if coords in top_walls.get_used_cells_by_id(0):
		tile_data.set_navigation_polygon(0, null)
	if coords in bottom_walls.get_used_cells_by_id(0):
		tile_data.set_navigation_polygon(0, null)
	if coords in furniture_map.get_used_cells_by_id(0):
		tile_data.set_navigation_polygon(0, null)
