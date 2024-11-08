extends GunToolGuiBase

@export var menus : Array[GunToolGuiBase] = [] :
	set(val):
		menus = val
		selected_max = menus.size() -1
		
@onready var menu_icons := get_tree().get_nodes_in_group("menu icon")

func _ready() -> void:
	show_menus()

func _scroll(val : int) -> void:
	super._scroll(val)
	sound_play(snd_option)
	for menu_icon in menu_icons:
		menu_icon.active = false
	menu_icons[selected].active = true
	show_menus()
	
func _trigger() -> void:
	sound_play(snd_option)
	var menu : GunToolGuiBase = menus[selected]
	enter(menu)
	match menu.name:
		"ShootingMode":
			self.visible = false
			
func show_menus() -> void:
	for menu in menus: menu.visible = false
	menus[selected].visible = true

func _on_exited() -> void:
	%Darken.visible = true
	%Backdrop.visible = false
	
func _on_entered() -> void:
	%Darken.visible = false
	%Backdrop.visible = true
	self.visible = true
