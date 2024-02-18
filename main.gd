extends Control
var at_start: bool = true
var is_playing : bool = false
var loop_element = preload("res://Components/loop_element.tscn")

func _ready() -> void:
	pass
			
func _on_button_menu_pressed() -> void:
	pass
	#SceneManager.set_scene("res://Components/SettingsDialog.tscn")


func _on_bpm_bpm_changed(bpm_value: int) -> void:
	$VBoxContainer/Metronome.bpm = bpm_value

func _on_button_microphone_finished_recording(recording: Variant) -> void:
	if recording != null:
		var to_add := loop_element.instantiate()
		to_add.set_recording(recording)
		to_add.connect("element_solo", _set_solo_element)
		$VBoxContainer/Loops.add_child(to_add)

func _set_solo_element(element) -> void:
	for l in $VBoxContainer/Loops.get_children():
		if l != element:
			l.mute()

func _on_metronome_current_beat(beat_no: int) -> void:
	if beat_no == 1:
		var microphone_button := $VBoxContainer/BottomButtons/ButtonMicrophone
		if microphone_button.is_recording():
			microphone_button.stop_recording()
		elif microphone_button.recording_queued:
			microphone_button.record()

			
		for l in $VBoxContainer/Loops.get_children():
			l.play()
