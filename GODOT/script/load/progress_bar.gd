extends ProgressBar

func _ready():
	value = 0
	var tween = create_tween()
	tween.tween_property(self, "value", 100, 15.0)
