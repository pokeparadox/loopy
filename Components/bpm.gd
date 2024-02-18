extends HBoxContainer

signal bpm_changed(bpm : int)

var _last_value : int = 140

func _bpm_value() -> int:
	var t :String = $TextEdit.text
	var i = int(t)
	return i
	
func _set_bpm_value(val : int) -> void:
	val = clampi(val, 0, 600)
	$TextEdit.text = str(val)
	_last_value = val
	emit_signal("bpm_changed", val)

func _on_button_decrease_pressed() -> void:
	var i = _bpm_value() - 1
	_set_bpm_value(i)

func _on_button_increase_pressed() -> void:
	var i = _bpm_value() + 1
	_set_bpm_value(i)

func _on_text_edit_text_changed() -> void:
	var t : String = $TextEdit.text
	if t.is_valid_int():
		_set_bpm_value(int(t))
	else:
		_set_bpm_value(_last_value)
	
