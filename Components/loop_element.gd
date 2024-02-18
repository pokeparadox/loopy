extends HBoxContainer

signal element_solo(element)
var _muted : bool = false

func set_recording(record : Variant) -> void:
	$SoundPlayer.stream = record

func mute() -> void:
	_muted = true

func play() -> void:
	if _muted:
		$LabelStatus.text = "Muted"
	else:
		$LabelStatus.text = "Playing..."
		$SoundPlayer.play()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_delete_pressed() -> void:
	self.queue_free()

func _on_button_mute_pressed() -> void:
	_muted = not _muted
	if _muted:
		$SoundPlayer.stop()
	else:
		$SoundPlayer.play()


func _on_button_solo_pressed() -> void:
	emit_signal("element_solo", self)
