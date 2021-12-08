extends Panel

var counter = 0
var timer = Timer.new()

func _ready():
	$Sentence_2.visible = false
	$Sentence_3.visible = false
	$Sentence_4.visible = false
	$Sentence_5.visible = false
	$Sentence_6.visible = false
	$Sentence_7.visible = false
	$Sentence_8.visible = false
	$Sentence_9.visible = false
	timer.set_wait_time( 5 )
	timer.set_one_shot(true)
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_timer_process_mode(0)
	timer.start()
	$Sentence_1.startAnimation()
	pass
	
func _on_Timer_timeout():
	match counter:
		0:
			$Sentence_1.visible = false
			$Sentence_2.visible = true
			$Sentence_2.startAnimation()
			counter += 1
		1:
			$Sentence_2.visible = false
			$Sentence_3.visible = true
			$Sentence_3.startAnimation()
			timer.set_wait_time( 7 )
			counter += 1
		2:
			$Sentence_3.visible = false
			$Sentence_4.visible = true
			$Sentence_4.startAnimation()
			timer.set_wait_time( 10 )
			counter += 1
		3:
			$Sentence_4.visible = false
			$Sentence_5.visible = true
			$Sentence_5.startAnimation()
			timer.set_wait_time( 10 )
			counter += 1
		4:
			$Sentence_5.visible = false
			$Sentence_6.visible = true
			$Sentence_6.startAnimation()
			timer.set_wait_time( 6 )
			counter += 1
		5:
			$Sentence_6.visible = false
			$Sentence_7.visible = true
			$Sentence_7.startAnimation()
			timer.set_wait_time( 8 )
			counter += 1
		6:
			$Sentence_7.visible = false
			$Sentence_8.visible = true
			$Sentence_8.startAnimation()
			timer.set_wait_time( 6 )
			counter += 1
		7:
			$Sentence_8.visible = false
			$Sentence_9.visible = true
			$Sentence_9.startAnimation()
			timer.set_wait_time( 15 )
			counter += 1
	timer.start()
