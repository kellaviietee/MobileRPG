extends Control

@export_multiline
var description = ""

var textboxResource = preload("res://Resources/Textbox.tres")

func _on_mouse_entered() -> void:
	var textbox = textboxResource.textbox
	if textbox:
		textbox.text = description


func _on_mouse_exited() -> void:
	var textbox = textboxResource.textbox
	if textbox:
		textbox.text = ""
