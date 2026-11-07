extends Node

@onready var ship: Tango = $/root/Main/Tango
var mining_turret_control = preload("res://scenes/mining_turret_control.tscn")

func _ready() -> void:
	$CanvasLayer/TopPanel/SpeedBar.max_value = ship.get_max_speed()
	$CanvasLayer/TopPanel/HullBar.max_value = ship.max_hull
	$CanvasLayer/TopPanel/ShieldBar.max_value = ship.max_shield
	
	for mining_turret in ship.get_mining_turrets():
		var control = mining_turret_control.instantiate()
		control.turret = mining_turret
		$CanvasLayer/TurretPanel.add_child(control)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		ship.accelerate()
	if Input.is_action_pressed("turn_left"):
		ship.turn_left()
	if Input.is_action_pressed("turn_right"):
		ship.turn_right()

func _process(_delta: float) -> void:
	$CanvasLayer/TopPanel/SpeedBar.value = ship.linear_velocity.length()
	$CanvasLayer/TopPanel/HullBar.value = ship.hull
	$CanvasLayer/TopPanel/ShieldBar.value = ship.shield
	$Camera2D.global_position = ship.global_position
