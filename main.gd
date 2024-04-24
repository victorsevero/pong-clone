extends Node

var score1 = 0
var score2 = 0

func _on_timer_timeout():
	$Ball.start()

func _on_ball_out():
	if $Ball.position.x < 0:
		score2 += 1
		$Score2.text = str(score2)
	elif $Ball.position.x > 160:
		score1 += 1
		$Score1.text = str(score1)
	else:
		print("Ball out at position ", $Ball.position)
	
	$Ball.reset()
	$Timer.start()