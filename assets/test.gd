extends Node3D
@onready var red_light = %lightTrafficMain_trafficVRed_0
@onready var yellow_light = %lightTrafficMain_trafficVYellow_0
@onready var green_light = %lightTrafficMain_trafficVGreen_0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_red()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_red():
	red_light.visible = true
	yellow_light.visible = false
	green_light.visible = false
