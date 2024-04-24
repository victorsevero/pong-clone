extends RigidBody2D

signal out

var speed: float
var velocity: Vector2
var start_position = Vector2(81, 60)

func _ready():
	reset()

func reset():
	position = Vector2(
		randi_range(start_position.x - 10, start_position.x + 10),
		randi_range(start_position.y - 10, start_position.y + 10),
	)
	velocity = Vector2.ZERO

func start():
	speed = 80
	var start_direction = [Vector2.LEFT, Vector2.RIGHT]
	velocity = start_direction.pick_random() * speed
	velocity = velocity.rotated(randf_range( - PI / 4, PI / 4))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		var normal = collision.get_normal()
		velocity = velocity.bounce(normal)

		if "player" in collision.get_collider().get_groups():
			$Bonk.play()
			speed *= 1.1
			var collider_y = collision.get_collider_velocity().y

			if collider_y != 0:
				velocity = velocity.rotated(sign(normal.x) * PI / 8)

			velocity = speed * velocity.normalized()

func _on_visible_on_screen_notifier_2d_screen_exited():
	out.emit()
