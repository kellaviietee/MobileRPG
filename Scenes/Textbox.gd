extends RichTextLabel

var textboxResource = preload("res://Resources/Textbox.tres")

func _ready() -> void:
	textboxResource.textbox = self

func _exit_tree() -> void:
	textboxResource.textbox = null
