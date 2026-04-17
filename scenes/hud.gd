extends Control
var love_brudt = 0

@onready var succestxt = $DoneScreen/SuccessText
@onready var fails = $FailScreen/FejlListe

@export var greystar := Texture
@export var yellowstar := Texture
@export var ThreeStarScore := 0
@export var TwoStarScore := 1
@export var OneStarScore := 2

@onready var stars := [$DoneScreen/StarContainer/Star, $DoneScreen/StarContainer/Star2, $DoneScreen/StarContainer/Star3]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("forhindringer"):
		i.lovbrudt.connect(_lovbrudt)
	for j in get_tree().get_nodes_in_group("slut"):
		j.slutning.connect(_slut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level_menu.tscn")


func _lovbrudt(message: String):
	love_brudt += 1
	var label = Label.new()
	label.add_theme_font_size_override("font_size", 16)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.text = message
	fails.add_child(label)


func _slut():
	if love_brudt <= 0:
		succestxt.text = "Ingen love brudt"
	else:
		succestxt.text = "Antal fejl: " + str(love_brudt)
	var x = get_amount(love_brudt)
	set_stars(x)
	get_tree().paused = true
	$DoneScreen.show()
	
func set_stars(antal : int):
	for i in range(stars.size()):
		if i < antal:
			stars[i].texture = yellowstar
		else:
			stars[i].texture = greystar

func get_amount(fejl : int):
	if fejl <= ThreeStarScore:
		return 3
	elif fejl <= TwoStarScore:
		return 2
	elif fejl <= OneStarScore:
		return 1
	else:
		return 0

func _on_fail_button_pressed() -> void:
	$FailScreen.show()


func _on_tilbage_pressed() -> void:
	$FailScreen.hide()
