extends RigidBody2D

func _process(delta):
	var colls = get_colliding_bodies()
	for coll in colls:
		if coll and coll.name == "gate":
			print("goal")