extends Area3D

var car_in = false
var car_stop = false
var lovbrud = false

signal lovbrudt(data)



@export var stop_sign: MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not car_in:
		return
	var car = get_overlapping_bodies().filter(func(b): return b.is_in_group("player_car"))
	if car[0].linear_velocity.length() <= 0.2:
		car_stop = true



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player_car"):
		var direction = body.linear_velocity.normalized()
		var allowed_direction = -stop_sign.global_basis.x.normalized()
		# tjekker om bilen og skiltet er den samme retning
		if direction.dot(allowed_direction) > 0.5:
			car_in = true
			lovbrud = false
			car_stop = false
		


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player_car"):
		if car_in:
			if not car_stop:
				lovbrud = true
			
			if lovbrud:
				lovbrudt.emit("Du stoppede ikke ved stopskiltet")
			car_in = false
		
