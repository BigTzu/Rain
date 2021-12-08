extends RichTextLabel

var counter = 0
var maxLength = self.text.length()
var timer = Timer.new()
var textNode = self.text

func _ready():
	add_child(timer)
	self.text = ""
	timer.connect("timeout", self, "_on_Timer_timeout")
	pass
	
func startAnimation():
	timer.set_wait_time( 0.05 )
	timer.set_one_shot(true)
	timer.set_timer_process_mode(0)
	timer.start()

func _on_Timer_timeout():
	counter += 1
	if counter < maxLength:
		self.set_bbcode("[fade start=" + str(counter) + " length=10]" + textNode + "[/fade]")
		timer.start()
