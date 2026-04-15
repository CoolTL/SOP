extends Control
var love_brudt = 0

@onready var succestxt = $DoneScreen/SuccessText
@onready var fails = $FailScreen/FejlListe



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("forhindringer"):
		i.lovbrudt.connect(_lovbrudt)
	for j in get_tree().get_nodes_in_group("slut"):
		j.slutning.connect(_slut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	$DoneScreen.show()
	


func _on_fail_button_pressed() -> void:
	$FailScreen.show()


func _on_tilbage_pressed() -> void:
	$FailScreen.hide()
