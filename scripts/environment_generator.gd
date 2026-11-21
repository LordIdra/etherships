class_name EnvironmentGenerator
extends Node

@onready var chard_node_scene = load("res://scenes/chard_node.tscn")

var radius: float = 1000
var node_min_distance: float = 100.0
var node_amount: int = 1000

func _ready() -> void:
	var remaining_nodes = node_amount
	while remaining_nodes > 0:
		var position = Vector2(radius * (2.0 * randf() - 1.0), radius * (2.0 * randf() - 1.0))
		remaining_nodes -= 1
