class_name SpeckCollector extends Node2D

var ship: Tango = null

func _ready():
	$CollectionArea2D.connect("body_entered", _collector_area_entered)

func _collector_area_entered(body: Node2D):
	print(1)
	if body is ChardSpeck:
		body.queue_free()
