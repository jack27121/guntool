extends GunToolGui

var options : Array[Node]

func _ready() -> void:
	selected_max = %OptionList.get_children().size() -1
	options = %OptionList.get_children()
	set_active()
	
func button() -> void:
	super.button()
	_leave()

func trigger() -> void:
	super.trigger()
	
	var option = options[selected]
	#if(option.can_enter()):
		#option.active = true
		#active_child = option
	#else: option.trigger()

func scroll(val : int) -> void:
	super.scroll(val)
	set_active()

func set_active() -> void:
	for option in options:
		option.active = false
	options[selected].active = true
