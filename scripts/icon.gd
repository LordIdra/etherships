class_name Icon extends Area2D

@export var texture: Texture2D
var normal_alpha: float = 0.6
var hovered_alpha: float = 0.8
var selected_alpha: float = 1.0

@onready var parent: Node = self.get_parent()
@onready var player_ship_controller = $/root/Main/PlayerShipController

func _ready() -> void:
	$Sprite2D.texture = texture
	set_alpha(normal_alpha)

func _mouse_enter() -> void:
	if parent is Tango && player_ship_controller.ship.target != parent:
		set_alpha(hovered_alpha)

func _mouse_exit() -> void:
	if parent is Tango && player_ship_controller.ship.target != parent:
		set_alpha(normal_alpha)

func set_alpha(alpha: float):
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, alpha)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if player_ship_controller.ship.target != null:
			player_ship_controller.ship.target.icon.set_alpha(normal_alpha)
		player_ship_controller.ship.target = parent
		if player_ship_controller.ship.target != null:
			player_ship_controller.ship.target.icon.set_alpha(selected_alpha)
