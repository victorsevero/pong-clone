extends CharacterBody2D

@export var controller_index = 0
@export var is_cpu = false
@export var x_start: float
var speed = 150

func _physics_process(_delta):
	position.x = x_start
	velocity = Vector2.ZERO

	if is_cpu:
		var ball = get_node("../Ball")
		if ball.position.y > position.y:
			velocity.y += speed
		elif ball.position.y < position.y:
			velocity.y -= speed
	else:
		if Input.is_action_pressed("up" + str(controller_index)):
			velocity.y -= speed
		if Input.is_action_pressed("down" + str(controller_index)):
			velocity.y += speed

	move_and_slide()