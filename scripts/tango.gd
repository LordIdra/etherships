class_name Tango extends RigidBody2D

@export var acceleration: float
@export var turn_acceleration: float
	
func accelerate():
	var facing = Vector2.UP.rotated(rotation)
	apply_central_force(facing * acceleration)

func turn_left():
	apply_torque(-turn_acceleration)

func turn_right():
	apply_torque(turn_acceleration)
