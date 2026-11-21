class_name MiningTurret extends Node2D

enum Status {
	BeamOn,
	RotatingToValidTarget,
	TargetOutOfRange,
	InvalidTarget,
	NoTarget,
	Initialising,
	Off,
}

@export var ship: Tango
@export var rotation_speed: float
@export var turret_range: float
@export var mine_chance: float

var beam_scene: PackedScene = preload("res://scenes/mining_beam.tscn")
var status: Status:
	set(value):
		if value != status:
			status = value
			status_updated.emit(value)
var beam: Line2D = null

signal status_updated(status: Status)

func _physics_process(delta: float) -> void:
	if ship.target != null:
		var rotation_step = rotation_speed * delta
		
		var target_angle = global_position.angle_to_point(ship.target.global_position) + PI / 2
		var requested_rotation_delta = angle_difference(global_rotation, target_angle)
		if absf(requested_rotation_delta) < rotation_step:
			global_rotation = target_angle
		else:
			global_rotation += sign(requested_rotation_delta) * min(absf(requested_rotation_delta), rotation_step)

func _process(delta: float) -> void:
	if status == Status.Off:
		pass
	elif ship.target == null:
		status = Status.Off
	elif ship.target is not ChardNode:
		status = Status.InvalidTarget
	elif !is_target_in_range():
		status = Status.TargetOutOfRange
	elif !is_pointing_at_target():
		status = Status.RotatingToValidTarget
	else:
		status = Status.BeamOn
	
	if status == Status.BeamOn && beam == null:
		beam = beam_scene.instantiate()
		add_child(beam)
	
	if status != Status.BeamOn && beam != null:
		beam.queue_free()
		beam = null
	
	if beam != null:
		beam.clear_points()
		beam.add_point(global_position)
		beam.add_point(ship.target.global_position)
		var target: ChardNode = ship.target
		if randf() < mine_chance * delta:
			target.mine(target.global_position - global_position)

func set_enabled(enabled: bool) -> void:
	if enabled:
		status = Status.Initialising
	else:
		status = Status.Off

func is_target_in_range():
	return ship.target != null && global_position.distance_to(ship.target.global_position) < turret_range

func is_pointing_at_target():
	var target_angle = global_position.angle_to_point(ship.target.global_position) + PI / 2
	return absf(angle_difference(global_rotation, target_angle)) < 1.0e-3
