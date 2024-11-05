extends GunToolGui

var menu_icons : Array
@export var menus : Array[GunToolGui] = [] :
	set(val):
		menus = val
		selected_max = menus.size() -1

func _ready() -> void:
	super._ready()
	menu_icons = get_tree().get_nodes_in_group("menu icon")
	show_menus()

func scroll(val : int) -> void:
	super.scroll(val)
	for menu_icon in menu_icons:
		menu_icon.active = false
	menu_icons[selected].active = true
	show_menus()
	
func show_menus() -> void:
	for menu in menus: menu.visible = false
	menus[selected].visible = true

func trigger() -> void:
	var menu : GunToolGui = menus[selected]
	enter(menu)
	match menu.name:
		"ShootingMode":
			self.visible = false

func on_exited() -> void:
	%Darken.visible = true
	%Backdrop.visible = false
	
func on_entered() -> void:
	%Darken.visible = false
	%Backdrop.visible = true
	self.visible = true
