class_name ChardNode extends RigidBody2D

@onready var icon: Node = $Icon

@export var initial_mass: float
@export var initial_scale: float

var speck_scene: PackedScene = load("res://scenes/chard_speck.tscn")

func _ready() -> void:
	mass = initial_mass
	recalculate_size()

func recalculate_size():
	var sprite_size = initial_scale * mass / initial_mass
	var collision_size = mass / initial_mass
	$Sprite2D.scale = Vector2(sprite_size, sprite_size)
	$CollisionPolygon2D.scale = Vector2(collision_size, collision_size)

func mine(direction: Vector2):
	# Create speck
	var speck: ChardSpeck = speck_scene.instantiate()
	$/root/Main/Specks.add_child(speck)
	speck.global_position = global_position
	speck.linear_velocity = -200.0 * direction.normalized()
	
	# Calculate new mass for node and speck
	speck.mass = min(speck.mass, mass)
	mass -= speck.mass
	if mass < 1.0e-6:
		queue_free()
	
	recalculate_size()
	
	# Disable speck collision until it exits the node
	var exit_detector = Area2D.new()
	exit_detector.collision_mask = speck.collision_mask
	exit_detector.add_child(speck.collision_polygon.duplicate())
	
	if !is_queued_for_deletion():
		speck.add_collision_exception_with(self)
		var on_exit = func(body: Node):
			if body == self:
				exit_detector.queue_free()
				speck.remove_collision_exception_with(self)
		exit_detector.connect("body_exited", on_exit)
		
	speck.add_child(exit_detector)
