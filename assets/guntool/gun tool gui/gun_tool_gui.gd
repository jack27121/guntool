extends GunToolGui
#enum e_modes {SHOOTING,SETTINGS}

@export var camera_viewport_main : SubViewport
@export var camera_main : Camera3D

signal shoot

var camera : Camera3D

func _ready() -> void:
	camera_reset()

func trigger() -> void:
	super.trigger()

func scroll(val : int) -> void:
	super.scroll(val)

func camera_reset() -> void:
	%CameraFeed.camera_viewport = camera_viewport_main
	%CameraFeed.framerate = 12
	camera = camera_main

#when exiting a mode the sidemenu becomes active
func _on_leave() -> void:
	active_child = %SideMenu
	%SideMenu.visible = true
	%SideMenu.darken(false)
	%Backdrop.visible = true

func _on_shooting_mode_shoot() -> void:
	shoot.emit()

func _on_side_menu_select(menu : GunToolGui) -> void:
	active_child = menu
	%Backdrop.visible = false
	%SideMenu.darken(true)
	if (menu == %ShootingMode): %SideMenu.visible = false
