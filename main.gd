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
		$VBoxContainer/Loops.add_child(to_add)

func _on_metronome_current_beat(beat_no: int) -> void:
	if beat_no == 1:
		if $VBoxContainer/BottomButtons/ButtonMicrophone.is_recording():
			$VBoxContainer/BottomButtons/ButtonMicrophone.stop_recording()
		for l in $VBoxContainer/Loops.get_children():
			l.play()
