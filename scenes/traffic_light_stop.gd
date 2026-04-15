extends Area3D

signal lovbrudt(message)

var red = false

@export var traffic_light: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_traffic_light_red() -> void:
	red = true


func _on_traffic_light_yellow() -> void:
	red = false


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player_car"):
		var direction = body.linear_velocity.normalized()
		var allowed_direction = -traffic_light.global_basis.z.normalized()
		# tjekker om bilen og skiltet er den samme retning
		if direction.dot(allowed_direction) > 0.5:
			if red:
				lovbrudt.emit("Du kørte over for rødt")
