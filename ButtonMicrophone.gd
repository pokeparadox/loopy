extends Button

signal finished_recording(recording)

var effect
var recording_queued : bool = false

func _ready() -> void:
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)

func is_recording() -> bool:
	return $AudioStreamRecord.is_playing()
	
func stop_recording() -> void:
	var recording = effect.get_recording()
	effect.set_recording_active(false)
	$AudioStreamRecord.stop()
	print("rocrding stopped")
	if recording != null:
		emit_signal("finished_recording", recording)

func record() -> void:
	recording_queued = false
	if not $AudioStreamRecord.playing:
		$AudioStreamRecord.play()
		effect.set_recording_active(true)
		print("Recording")
		
func _on_button_down() -> void:
	recording_queued = true
	print(recording_queued)

