extends Area3D

@export var speed_limit = 50
@export var tolerance = 2

var car_in = false
var lovbrud = false
signal lovbrudt(message)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not car_in:
		return
		
	var car = get_overlapping_bodies().filter(func(b): return b.is_in_group("player_car"))
	var speed_kph = car[0].linear_velocity.length() * 3.6
	if speed_kph > speed_limit + tolerance:
		lovbrud = true
		


func _on_body_entered(body: Node3D) -> void:
	print("test")
	if body.is_in_group("player_car"):
		print("works")
		car_in = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player_car"):
		car_in = false
		
		if lovbrud:
			lovbrudt.emit("Du kørte for hurtigt")
		
		lovbrud = false
