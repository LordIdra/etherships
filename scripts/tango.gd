class_name Tango extends RigidBody2D

@export var acceleration_force: float
@export var turn_acceleration: float
@export var max_hull: float
@export var max_shield: float
@export var max_chard: float

@onready var hull: float = max_hull
@onready var shield: float = max_shield
@onready var chard_amount: float = 0
@onready var icon: Icon = $Icon

var target: Node = null:
	set(value):
		if target == value:
			return
		if target != null:
			target.disconnect("tree_exited", _target_exited_tree)
		target = value
		if target != null:
			target.connect("tree_exited", _target_exited_tree)
		target_updated.emit()

signal target_updated

func _target_exited_tree():
	target = null

func get_max_speed():
	return acceleration_force / (mass * linear_damp)

func get_mining_turrets():
	var mining_turrets = []
	for child in get_children():
		if child is MiningTurret:
			mining_turrets.append(child)
	return mining_turrets

func accelerate():
	var facing = Vector2.UP.rotated(rotation)
	apply_central_force(facing * acceleration_force)

func turn_left():
	apply_torque(-turn_acceleration)

func turn_right():
	apply_torque(turn_acceleration)
