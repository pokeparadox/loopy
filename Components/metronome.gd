extends HBoxContainer

signal current_beat(beat_no : int)

var interval : float = 0.0
var bpm : int : 
	set(value):
		interval = _calculate_interval_ms(value)
		$Timer.wait_time = interval / 1000.0

var _current_beat : int = 1

func play() -> void:
	$Timer.start()
	$Timer.set_paused(false)

func stop() -> void:
	$Timer.stop()

func reset() -> void:
	stop()
	_current_beat = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_current_beat = 1
	bpm = 140
	play()

func _set_active_button() -> void:
	match(_current_beat):
		1:
			$Button1.button_pressed = not $Button1.button_pressed
			$AudioClap.play()
		2:
			$Button2.button_pressed = not $Button2.button_pressed
			$AudioTick.play()
		3:
			$Button3.button_pressed = not $Button3.button_pressed
			$AudioTick.play()
		4:
			$Button4.button_pressed = not $Button4.button_pressed
			$AudioTick.play()
	
func _calculate_interval_ms(bpm_value : int) -> float:
	return 60000.0 / float(bpm_value)

func _on_timer_timeout() -> void:
	_current_beat = _current_beat + 1
	_current_beat = wrapi(_current_beat, 1, 5)
	_set_active_button()
	emit_signal("current_beat", _current_beat)
