extends Button

@export var level : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	var index = parent.get_children().find(self)
	text = str(index + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if level:
		get_tree().change_scene_to_packed(level)
