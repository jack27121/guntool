extends VisibleOnScreenNotifier3D

var highlight : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if highlight:
		SignalBus.emit_signal("_highlight_component",get_parent_node_3d().global_position)

func _on_screen_exited() -> void:
	highlight = false


func _on_screen_entered() -> void:
	highlight = true
