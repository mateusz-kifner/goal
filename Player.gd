extends KinematicBody2D
var bullet = preload("res://Bullet.tscn")

var score = 0;
var can_shoot = true
var time = 200

func _process(delta):
	if time < 0:
		can_shoot = true
		time = 200
		for bullet in get_parent().find_node("Bullets").get_children():
			bullet.queue_free()
				
	if not(can_shoot):
		time-=1
	if(Input.is_action_pressed("ui_left")):
		rotate((-PI)*delta)
	if(Input.is_action_pressed("ui_right")):
		rotate((PI)*delta)
	if(Input.is_action_just_pressed("ui_select")) and can_shoot:
		can_shoot = false
		var new_bullet = bullet.instance()
		new_bullet.rotate(rotation)
		new_bullet.position = $Position2D.global_position
		new_bullet.apply_impulse(Vector2(),Vector2(0,-900).rotated(rotation))
		get_parent().find_node("Bullets").add_child(new_bullet)

func _on_gate_body_entered(body):
	score+=1
	can_shoot = true
	for bullet in get_parent().find_node("Bullets").get_children():
		bullet.queue_free()
	get_tree().get_root().get_node("Main/Control/Score").text = "Score: " + str(score)
