class_name SpeckCollector extends Node2D

@onready var ship: Tango = get_parent()

func _ready():
	$CollectionArea2D.connect("body_entered", _collector_area_entered)

func _collector_area_entered(body: Node2D):
	var speck := body as ChardSpeck
	if speck != null && speck.mass < (ship.max_chard - ship.chard_amount + 1.0e-6):
		ship.chard_amount += speck.mass
		body.queue_free()
