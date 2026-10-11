class_name PlayerShipController extends Node

@onready var ship: Tango = get_parent()

func _ready() -> void:
	pass

func _physics_process(aa_delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		ship.accelerate()
	if Input.is_action_pressed("turn_left"):
		ship.turn_left()
	if Input.is_action_pressed("turn_right"):
		ship.turn_right()
