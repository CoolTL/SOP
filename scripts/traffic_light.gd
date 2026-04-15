extends Node3D

enum LightState {RED, GREEN, YELLOW}

@export var red_time := 6.0
@export var yellow_time := 2.0
@export var green_time := 6.0

@export var red_light: Node3D
@export var yellow_light: Node3D
@export var green_light: Node3D

signal red
signal yellow

var state = LightState.RED
var timer = 0.0
var safety = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	red_light = get_node("Sketchfab_Scene/Sketchfab_model/194a19289741436e83654c9d7d027ce6_fbx/RootNode/lightTrafficMain/lightTrafficMain_trafficVRed_0")
	yellow_light = get_node("Sketchfab_Scene/Sketchfab_model/194a19289741436e83654c9d7d027ce6_fbx/RootNode/lightTrafficMain/lightTrafficMain_trafficVYellow_0")
	green_light = get_node("Sketchfab_Scene/Sketchfab_model/194a19289741436e83654c9d7d027ce6_fbx/RootNode/lightTrafficMain/lightTrafficMain_trafficVGreen_0")
	timer = red_time
	set_red()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		next_state()
	
func next_state():
	match state:
		LightState.RED:
			state = LightState.YELLOW
			timer = yellow_time
			set_yellow()
			yellow.emit()
			safety += 1
		LightState.GREEN:
			state = LightState.YELLOW
			set_yellow()
			timer = yellow_time
			safety += 1
		LightState.YELLOW:
			if safety%2 == 0:
				state = LightState.RED
				set_red()
				timer = red_time
			else:
				state = LightState.GREEN
				set_green()
				timer = green_time
	
	
func set_red():
	red_light.visible = true
	yellow_light.visible = false
	green_light.visible = false
	red.emit()

func set_yellow():
	red_light.visible = false
	yellow_light.visible = true
	green_light.visible = false

func set_green():
	red_light.visible = false
	yellow_light.visible = false
	green_light.visible = true
