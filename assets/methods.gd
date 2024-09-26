extends Node3D

func raycast(from : Vector3, to : Vector3, coll_mask : int = 0xFFFFFFFF, exclude : Array[RID] = []) -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters3D.create(from, to, coll_mask,  exclude)
	var result : Dictionary = space_state.intersect_ray(query)
	
	return result
