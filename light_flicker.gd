extends OmniLight3D

@export var flicker_speed_min := 0.02
@export var flicker_speed_max := 1.0
@export var intensity_min := 0.0
@export var intensity_max := 1.5

var original_energy := 1.0

func _ready():
	original_energy = light_energy
	_start_flicker()

func _start_flicker():
	var flicker_time = randf_range(flicker_speed_min, flicker_speed_max)
	await get_tree().create_timer(flicker_time).timeout
	
	var flicker_pattern = randi_range(0, 4)

	match flicker_pattern:
		0:
			light_energy = 0.0
		1:
			light_energy = randf_range(0.2, 0.5)
		2:
			light_energy = randf_range(0.8, 1.5)
		3:
			light_energy = 0.0
			await get_tree().create_timer(0.1).timeout
			light_energy = original_energy
		_:
			light_energy = original_energy

	_start_flicker()
