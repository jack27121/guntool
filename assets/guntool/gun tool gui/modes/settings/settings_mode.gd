@tool

extends GunToolGui

var options : Array[Node]



func _ready() -> void:
	super._ready()
	selected_max = %OptionList.get_children().size() -1
	options = %OptionList.get_children()
	#for option in options:
		#guntool.get()
	set_active()
	
func button() -> void:
	exit()

func trigger() -> void:	
	var option = options[selected]
	option.trigger()

func scroll(val : int) -> void:
	super.scroll(val)
	set_active()

func set_active() -> void:
	if(options.size() > 0):
		for option in options:
			option.active = false
		options[selected].active = true
