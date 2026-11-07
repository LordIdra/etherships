class_name MiningTurretControl extends Button

var turret: MiningTurret

func _ready() -> void:
	turret.status_updated.connect(_turret_status_updated)
	text = turret.name

func _toggled(toggled_on: bool) -> void:
	turret.set_enabled(toggled_on)	

func update_color():
	var stylebox = StyleBoxFlat.new()
	match turret.status:
		MiningTurret.Status.BeamOn:
			stylebox.bg_color = Color.from_rgba8(26, 115, 97, 255)
		MiningTurret.Status.RotatingToValidTarget:
			stylebox.bg_color = Color.from_rgba8(128, 127, 57, 255)
		MiningTurret.Status.TargetOutOfRange:
			stylebox.bg_color = Color.from_rgba8(138, 83, 67, 255)
		MiningTurret.Status.InvalidTarget:
			stylebox.bg_color = Color.from_rgba8(165, 54, 81, 255)
	add_theme_stylebox_override("pressed", stylebox)

func _turret_status_updated(enabled: bool):
	var turret_enabled = turret.status != MiningTurret.Status.Off
	if button_pressed != turret_enabled:
		button_pressed = enabled
	update_color()
